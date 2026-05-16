# otel_graphql_flutter

Flutter overlay for [`otel_graphql`](../otel_graphql/README.md).

Re-exports the core `OTelGraphqlLink` + `GraphqlSemantics` and
pulls in `graphql_flutter` so Flutter apps add **one** dependency
instead of managing `graphql` + `graphql_flutter` +
`otel_graphql` separately.

```dart
import 'package:otel_graphql_flutter/otel_graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final client = GraphQLClient(
  link: Link.from([
    OTelGraphqlLink(),
    HttpLink('https://api.example.com/graphql'),
  ]),
  cache: GraphQLCache(),
);
```

## Choosing this vs. `otel_graphql`

- **Flutter app using `graphql_flutter`** → use this package. One
  dependency for the link + `graphql_flutter`.
- **Pure-Dart `graphql` app** (a server, CLI, isolate) → use
  [`otel_graphql`](../otel_graphql) directly.
  No Flutter dependency.

The runtime behavior is identical — same `OTelGraphqlLink` class
in both cases.

## What this package adds beyond re-exports

Nothing today, by design. GraphQL instrumentation hooks at the
`Link` chain level, which works the same whether you're using
`graphql_flutter`'s widgets or `graphql` directly. If a future
Flutter-shaped affordance becomes worth shipping (a
`GraphQLProvider` wrapper that auto-installs the link, say), it
lands here.

## License

Apache 2.0 — see `LICENSE`.
