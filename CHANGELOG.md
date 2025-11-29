# Changelog

All notable changes to ATProtoFoundation will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2025-11-29

### Changed

- **Renamed classes to remove "Iron Session" naming** (breaking change for imports)
  - `IronSessionMobileOAuthCoordinator` → `MobileOAuthCoordinator`
  - `IronSessionAPIClient` → `BFFAPIClient`
  - `completeIronSessionOAuthFlow()` → `completeOAuthFlow()`
  - `refreshIronSession()` → `refreshSession()`
  - Placeholder tokens changed from `"iron-session-backend-managed"` to `"backend-managed"`

  The old names leaked a backend implementation detail. "Iron Session" refers to an npm package used by the server - the Swift client simply handles opaque session tokens via cookies and has no dependency on iron-session.

- **Renamed `ATProtoRecord` to `BlueskyPostRecord`** (breaking change for imports)

  The struct specifically represents Bluesky posts (`app.bsky.feed.post`), not generic AT Protocol records. The new name accurately reflects its purpose.

## [1.1.0] - 2025-11-29

### Added

- **Documentation**
  - DocC documentation catalog with API reference
  - Getting Started guide for new users
  - `.spi.yml` manifest for Swift Package Index documentation builds
  - `.gitignore` for build artifacts

## [1.0.0] - 2025-11-29

### Added

- **Models**
  - `BlueskyPostRecord`, `ATProtoFacet`, `ATProtoFeature` for rich text handling with markdown formatting
  - `TimelineRecord`, `TimelineFacet`, `FacetIndex`, `FacetFeature` for API response parsing
  - `AuthCredentials` and `AuthCredentialsProtocol` for authentication data
  - `AuthenticationState` enum for auth state management
  - `CommunityLexicon` and `BlueskyLexicon` constants for lexicon identifiers

- **Authentication**
  - `MobileOAuthCoordinator` for Backend-For-Frontend OAuth pattern
  - `OAuthConfiguration` for centralized OAuth settings
  - `CookieManager` for HTTP cookie management
  - `CredentialsStorageProtocol` with implementations:
    - `KeychainCredentialsStorage` for secure production storage
    - `InMemoryCredentialsStorage` for testing

- **Networking**
  - `BFFAPIClient` for HTTP requests with session management
  - Multipart form data support for file uploads
  - `URLSessionProtocol` for testability

- **Utilities**
  - `ISO8601DateFormatter.flexibleDate()` for flexible date parsing
  - `RichTextProcessor` for processing rich text content
  - `Logger` protocol with `DebugLogger` and `SilentLogger` implementations

- **Testing**
  - Comprehensive test suite using Swift Testing framework
  - Test utilities and tags for organized test execution
