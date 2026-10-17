# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1] - 2026-10-17

### Changed

- README: standard header naming the instrumented library, its supported platforms and project links; pubspec description to match.

## [0.2.0] - 2026-10-11

### Changed

- Requires `dartastic_opentelemetry_api >=1.0.0-rc.4 <1.0.0-rc.5`.
- Requires `otel_graphql ^0.3.0`, the API-only release.
- **Breaking:** depends on `dartastic_opentelemetry_api` only, no
  longer on the SDK. The application chooses and initializes the
  OpenTelemetry SDK. Parameters and fields typed with SDK classes
  now use the API types (`APITracer`, `APISpan`, `APILogger`, ...);
  SDK instances are still accepted wherever an API type is expected.

## [0.1.0] - 2026-08-10

### Added

- Slim Flutter overlay for `otel_graphql`. Re-exports
  the core link and pulls in `graphql_flutter` so
  Flutter apps add one dependency instead of managing `graphql` +
  `graphql_flutter` + the core package separately.
- Targets `graphql_flutter: ^5.0.0`. No new types yet — GraphQL
  instrumentation hooks at the `gql_link` level, which works the
  same regardless of UI binding.

### Changed

- Sibling floor fixed to `otel_graphql: ^0.1.0-beta.1` (the
  published core release; a `-wip` floor can never resolve on
  pub.dev).
- Raised SDK floors to `dartastic_opentelemetry ^1.1.0-beta.12` /
  `dartastic_opentelemetry_api ^1.0.0-rc.1`, matching the core
  package.
- Dropped the `GraphqlSemantics` re-export — the core package now
  keeps its attribute keys internal to `OTelGraphqlLink`.
