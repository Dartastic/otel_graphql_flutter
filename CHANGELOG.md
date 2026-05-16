# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0-beta.1-wip]

### Added

- Slim Flutter overlay for `dartastic_graphql_otel`. Re-exports
  the core link + semantics and pulls in `graphql_flutter` so
  Flutter apps add one dependency instead of managing `graphql` +
  `graphql_flutter` + the core package separately.
- Targets `graphql_flutter: ^5.0.0`. No new types yet — GraphQL
  instrumentation hooks at the `gql_link` level, which works the
  same regardless of UI binding.
