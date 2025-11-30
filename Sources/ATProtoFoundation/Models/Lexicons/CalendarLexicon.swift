import Foundation

// MARK: - Calendar Lexicon Models

/// Event attendance mode
public enum CalendarEventMode: String, Codable, Sendable, Hashable {
    case virtual = "community.lexicon.calendar.event#virtual"
    case inPerson = "community.lexicon.calendar.event#inperson"
    case hybrid = "community.lexicon.calendar.event#hybrid"
}

/// Event status
public enum CalendarEventStatus: String, Codable, Sendable, Hashable {
    case planned = "community.lexicon.calendar.event#planned"
    case scheduled = "community.lexicon.calendar.event#scheduled"
    case rescheduled = "community.lexicon.calendar.event#rescheduled"
    case cancelled = "community.lexicon.calendar.event#cancelled"
    case postponed = "community.lexicon.calendar.event#postponed"
}

/// RSVP status for calendar events
public enum RSVPStatus: String, Codable, Sendable, Hashable {
    case interested = "community.lexicon.calendar.rsvp#interested"
    case going = "community.lexicon.calendar.rsvp#going"
    case notGoing = "community.lexicon.calendar.rsvp#notgoing"
}

/// A URI associated with a calendar event
///
/// Conforms to `community.lexicon.calendar.event#uri`
public struct CalendarEventURI: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// The URI
    public let uri: String

    /// Optional display name for the URI
    public let name: String?

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case uri
        case name
    }

    public init(uri: String, name: String? = nil) {
        self.type = "community.lexicon.calendar.event#uri"
        self.uri = uri
        self.name = name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
            ?? "community.lexicon.calendar.event#uri"
        self.uri = try container.decode(String.self, forKey: .uri)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

/// A location that can be used in calendar events.
///
/// Supports multiple location types from the community lexicon.
public enum CalendarEventLocation: Codable, Sendable, Hashable {
    case uri(CalendarEventURI)
    case address(CommunityAddress)
    case foursquare(FoursquareLocation)
    case geo(GeoCoordinates)
    case h3(H3Location)

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .uri(let uri):
            try uri.encode(to: encoder)
        case .address(let address):
            try address.encode(to: encoder)
        case .foursquare(let fsq):
            try fsq.encode(to: encoder)
        case .geo(let geo):
            try geo.encode(to: encoder)
        case .h3(let h3):
            try h3.encode(to: encoder)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "community.lexicon.calendar.event#uri":
            self = .uri(try CalendarEventURI(from: decoder))
        case CommunityLexicon.locationAddress:
            self = .address(try CommunityAddress(from: decoder))
        case CommunityLexicon.locationFoursquare:
            self = .foursquare(try FoursquareLocation(from: decoder))
        case CommunityLexicon.locationGeo:
            self = .geo(try GeoCoordinates(from: decoder))
        case CommunityLexicon.locationH3:
            self = .h3(try H3Location(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown location type: \(type)"
                )
            )
        }
    }
}

/// A calendar event record.
///
/// Conforms to `community.lexicon.calendar.event`
public struct CalendarEvent: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// The name of the event
    public let name: String

    /// Optional description of the event
    public let description: String?

    /// When the event record was created
    public let createdAt: Date

    /// When the event starts
    public let startsAt: Date?

    /// When the event ends
    public let endsAt: Date?

    /// The attendance mode of the event
    public let mode: CalendarEventMode?

    /// The status of the event
    public let status: CalendarEventStatus?

    /// Locations where the event takes place
    public let locations: [CalendarEventLocation]?

    /// URIs associated with the event
    public let uris: [CalendarEventURI]?

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case name
        case description
        case createdAt
        case startsAt
        case endsAt
        case mode
        case status
        case locations
        case uris
    }

    public init(
        name: String,
        description: String? = nil,
        createdAt: Date = Date(),
        startsAt: Date? = nil,
        endsAt: Date? = nil,
        mode: CalendarEventMode? = nil,
        status: CalendarEventStatus? = nil,
        locations: [CalendarEventLocation]? = nil,
        uris: [CalendarEventURI]? = nil
    ) {
        self.type = CommunityLexicon.calendarEvent
        self.name = name
        self.description = description
        self.createdAt = createdAt
        self.startsAt = startsAt
        self.endsAt = endsAt
        self.mode = mode
        self.status = status
        self.locations = locations
        self.uris = uris
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
            ?? CommunityLexicon.calendarEvent
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.startsAt = try container.decodeIfPresent(Date.self, forKey: .startsAt)
        self.endsAt = try container.decodeIfPresent(Date.self, forKey: .endsAt)
        self.mode = try container.decodeIfPresent(CalendarEventMode.self, forKey: .mode)
        self.status = try container.decodeIfPresent(CalendarEventStatus.self, forKey: .status)
        self.locations = try container.decodeIfPresent([CalendarEventLocation].self, forKey: .locations)
        self.uris = try container.decodeIfPresent([CalendarEventURI].self, forKey: .uris)
    }
}

/// An RSVP for a calendar event.
///
/// Conforms to `community.lexicon.calendar.rsvp`
public struct CalendarRSVP: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// Reference to the event being responded to
    public let subject: StrongRef

    /// The RSVP status
    public let status: RSVPStatus

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case subject
        case status
    }

    public init(subject: StrongRef, status: RSVPStatus) {
        self.type = CommunityLexicon.calendarRSVP
        self.subject = subject
        self.status = status
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
            ?? CommunityLexicon.calendarRSVP
        self.subject = try container.decode(StrongRef.self, forKey: .subject)
        self.status = try container.decode(RSVPStatus.self, forKey: .status)
    }
}
