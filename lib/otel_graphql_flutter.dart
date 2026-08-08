// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

/// Flutter overlay for `otel_graphql`.
///
/// Re-exports the core `OTelGraphqlLink`. A
/// Flutter app that depends on `graphql_flutter` can add this
/// single package instead of pulling in both `otel_graphql`
/// and managing the `graphql_flutter` / `graphql` dependency
/// separately.
///
/// See [OTelGraphqlLink] in `otel_graphql` for the full
/// configuration surface and span-shape reference.
library;

export 'package:otel_graphql/otel_graphql.dart';
