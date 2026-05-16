// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otel_graphql_flutter/otel_graphql_flutter.dart';

void main() {
  test('overlay re-exports OTelGraphqlLink + GraphqlSemantics', () async {
    await OTel.reset();
    await OTel.initialize(
      serviceName: 'graphql-flutter-otel-overlay-test',
      detectPlatformResources: false,
    );

    // Construct + reference both symbols to ensure the re-export
    // covers them.
    final link = OTelGraphqlLink();
    expect(link, isNotNull);
    expect(
        GraphqlSemantics.operationType.key, equals('graphql.operation.type'));

    await OTel.shutdown();
    await OTel.reset();
  });
}
