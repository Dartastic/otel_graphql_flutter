# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0-wip]

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
