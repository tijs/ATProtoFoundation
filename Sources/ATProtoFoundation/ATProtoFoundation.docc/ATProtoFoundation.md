# ``ATProtoFoundation``

A Swift package providing foundational types and utilities for building AT Protocol (atproto) iOS applications.

## Overview

ATProtoFoundation provides the building blocks for iOS apps that interact with the AT Protocol network (including Bluesky). It includes:

- Rich text record types with facet support (links, mentions, hashtags)
- Community lexicon models (bookmarks, calendar, interactions, locations, payments)
- BFF (Backend-For-Frontend) OAuth authentication pattern
- Secure credential storage options
- Timeline API response parsing
- Date parsing utilities

## Topics

### Essentials

- <doc:GettingStarted>

### Records and Rich Text

- ``BlueskyPostRecord``
- ``ATProtoFacet``
- ``ATProtoFeature``
- ``RichTextFacet``
- ``RichTextFeature``
- ``ByteRange``

### Timeline Models

- ``TimelineRecord``
- ``TimelineFacet``
- ``FacetFeature``

### Community Lexicon Models

#### Bookmarks
- ``Bookmark``

#### Calendar
- ``CalendarEvent``
- ``CalendarRSVP``
- ``CalendarEventURI``
- ``CalendarEventLocation``
- ``CalendarEventMode``
- ``CalendarEventStatus``
- ``RSVPStatus``

#### Interactions
- ``InteractionLike``

#### Locations
- ``GeoCoordinates``
- ``CommunityAddress``
- ``FoursquareLocation``
- ``H3Location``

#### Payments
- ``WebMonetizationWallet``

### Core Protocol Types

- ``StrongRef``
- ``ATProtoError``

### Authentication

- ``MobileOAuthCoordinator``
- ``OAuthConfiguration``
- ``AuthCredentials``
- ``AuthCredentialsProtocol``
- ``AuthenticationState``

### Credentials Storage

- ``CredentialsStorageProtocol``
- ``KeychainCredentialsStorage``
- ``InMemoryCredentialsStorage``

### Networking

- ``BFFAPIClient``
- ``URLSessionProtocol``

### Utilities

- ``ISO8601DateFormatter``
- ``RichTextProcessor``
- ``Logger``

### Lexicon Constants

- ``BlueskyLexicon``
- ``CommunityLexicon``
