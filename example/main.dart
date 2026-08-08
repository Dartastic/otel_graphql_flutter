// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

// Minimal Flutter example: put [OTelGraphqlLink] FIRST in the link
// chain so its span encloses everything downstream (auth, retry, the
// HTTP transport). One span per operation: name `query GetUser`,
// attributes graphql.operation.type / graphql.operation.name.
// Variables are never captured.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:otel_graphql_flutter/otel_graphql_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Bring up OTel first so trace context is flowing before the
  //    first operation executes.
  await OTel.initialize(serviceName: 'graphql-flutter-example');

  // 2. Compose the chain: OTelGraphqlLink first, transport last.
  final client = ValueNotifier(
    GraphQLClient(
      link: Link.from([
        OTelGraphqlLink(),
        HttpLink('https://api.example.com/graphql'),
      ]),
      cache: GraphQLCache(),
    ),
  );

  runApp(GraphQLProvider(client: client, child: const ExampleApp()));
}

/// Queries run through the provider's client are traced — no other
/// changes to widget code.
class ExampleApp extends StatelessWidget {
  /// Creates the example app.
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('otel_graphql_flutter')),
        body: Query(
          options: QueryOptions(
            document: gql('query GetUser { user { id name } }'),
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Center(child: Text('${result.exception}'));
            }
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(child: Text('${result.data}'));
          },
        ),
      ),
    );
  }
}
