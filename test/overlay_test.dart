// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:otel_graphql_flutter/otel_graphql_flutter.dart';

class _MemorySpanExporter implements SpanExporter {
  final List<Span> spans = [];
  bool _shutdown = false;

  @override
  Future<void> export(List<Span> s) async {
    if (_shutdown) return;
    spans.addAll(s);
  }

  @override
  Future<void> forceFlush() async {}

  @override
  Future<void> shutdown() async {
    _shutdown = true;
  }
}

/// Terminating link so the chain runs without a server.
class _EchoLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    yield const Response(
      data: <String, dynamic>{'ping': true},
      response: <String, dynamic>{},
    );
  }
}

void main() {
  late _MemorySpanExporter exporter;

  setUp(() async {
    await OTel.reset();
    exporter = _MemorySpanExporter();
    await OTel.initialize(
      serviceName: 'graphql-flutter-otel-overlay-test',
      detectPlatformResources: false,
      spanProcessor: SimpleSpanProcessor(exporter),
    );
  });

  tearDown(() async {
    await OTel.shutdown();
    await OTel.reset();
  });

  test('overlay re-exports OTelGraphqlLink', () {
    // Construct the symbol to ensure the re-export covers it.
    final link = OTelGraphqlLink();
    expect(link, isNotNull);
    expect(link.recordDocument, isFalse,
        reason: 'document capture must default OFF (PII)');
  });

  test(
      'link chained through graphql_flutter types emits one span '
      'per operation', () async {
    final chain = Link.from([OTelGraphqlLink(), _EchoLink()]);

    final request = Request(
      operation: Operation(
        document: gql('query GetUser { user { id name } }'),
        operationName: 'GetUser',
      ),
    );
    await chain.request(request).drain<void>();

    expect(exporter.spans, hasLength(1));
    final span = exporter.spans.single;
    expect(span.name, equals('query GetUser'));
    final attrs = {
      for (final a in span.attributes.toList()) a.key: a.value,
    };
    expect(attrs['graphql.operation.type'], equals('query'));
    expect(attrs['graphql.operation.name'], equals('GetUser'));
    // Document is never captured unless explicitly opted in.
    expect(attrs.containsKey('graphql.document'), isFalse);
  });
}
