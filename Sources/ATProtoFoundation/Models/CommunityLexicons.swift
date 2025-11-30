import Foundation

// MARK: - Community Lexicon Type Constants

/// AT Protocol community lexicon type identifiers
///
/// Community lexicons provide standardized schemas for common data types.
/// These constants represent well-known community lexicons that can be used
/// across AT Protocol applications.
///
/// Apps can extend this enum with their own lexicon types:
/// ```swift
/// extension CommunityLexicon {
///     public static let myCustomType = "my.app.custom.type"
/// }
/// ```
public enum CommunityLexicon {
    // MARK: - Bookmarks Lexicons

    /// Bookmark record: `community.lexicon.bookmarks.bookmark`
    ///
    /// Record bookmarking a link to come back to later.
    public static let bookmark = "community.lexicon.bookmarks.bookmark"

    // MARK: - Calendar Lexicons

    /// Calendar event: `community.lexicon.calendar.event`
    ///
    /// A calendar event with name, description, dates, and locations.
    public static let calendarEvent = "community.lexicon.calendar.event"

    /// RSVP record: `community.lexicon.calendar.rsvp`
    ///
    /// An RSVP for a calendar event.
    public static let calendarRSVP = "community.lexicon.calendar.rsvp"

    // MARK: - Calendar Event Modes

    /// Virtual event mode: `community.lexicon.calendar.event#virtual`
    public static let calendarEventModeVirtual = "community.lexicon.calendar.event#virtual"

    /// In-person event mode: `community.lexicon.calendar.event#inperson`
    public static let calendarEventModeInPerson = "community.lexicon.calendar.event#inperson"

    /// Hybrid event mode: `community.lexicon.calendar.event#hybrid`
    public static let calendarEventModeHybrid = "community.lexicon.calendar.event#hybrid"

    // MARK: - Calendar Event Status

    /// Planned event status: `community.lexicon.calendar.event#planned`
    public static let calendarEventStatusPlanned = "community.lexicon.calendar.event#planned"

    /// Scheduled event status: `community.lexicon.calendar.event#scheduled`
    public static let calendarEventStatusScheduled = "community.lexicon.calendar.event#scheduled"

    /// Rescheduled event status: `community.lexicon.calendar.event#rescheduled`
    public static let calendarEventStatusRescheduled = "community.lexicon.calendar.event#rescheduled"

    /// Cancelled event status: `community.lexicon.calendar.event#cancelled`
    public static let calendarEventStatusCancelled = "community.lexicon.calendar.event#cancelled"

    /// Postponed event status: `community.lexicon.calendar.event#postponed`
    public static let calendarEventStatusPostponed = "community.lexicon.calendar.event#postponed"

    // MARK: - RSVP Status

    /// Interested RSVP status: `community.lexicon.calendar.rsvp#interested`
    public static let rsvpStatusInterested = "community.lexicon.calendar.rsvp#interested"

    /// Going RSVP status: `community.lexicon.calendar.rsvp#going`
    public static let rsvpStatusGoing = "community.lexicon.calendar.rsvp#going"

    /// Not going RSVP status: `community.lexicon.calendar.rsvp#notgoing`
    public static let rsvpStatusNotGoing = "community.lexicon.calendar.rsvp#notgoing"

    // MARK: - Interaction Lexicons

    /// Like interaction: `community.lexicon.interaction.like`
    ///
    /// A 'like' interaction with another AT Protocol record.
    public static let interactionLike = "community.lexicon.interaction.like"

    // MARK: - Location Lexicons

    /// Geographic coordinates: `community.lexicon.location.geo`
    ///
    /// Represents a geographic point with latitude and longitude.
    public static let locationGeo = "community.lexicon.location.geo"

    /// Physical address: `community.lexicon.location.address`
    ///
    /// Structured address data with name, street, locality, region, country, and postal code.
    public static let locationAddress = "community.lexicon.location.address"

    /// Foursquare location: `community.lexicon.location.fsq`
    ///
    /// A physical location from the Foursquare Open Source Places dataset.
    public static let locationFoursquare = "community.lexicon.location.fsq"

    /// H3 encoded location: `community.lexicon.location.hthree`
    ///
    /// A physical location in H3 encoded format.
    public static let locationH3 = "community.lexicon.location.hthree"

    // MARK: - Payments Lexicons

    /// Web Monetization wallet: `community.lexicon.payments.webMonetization`
    ///
    /// Web Monetization integration for wallet addresses.
    public static let webMonetization = "community.lexicon.payments.webMonetization"
}

// MARK: - Bluesky Lexicon Type Constants

/// Bluesky-specific lexicon type identifiers
///
/// These are the official Bluesky app lexicons for social features.
public enum BlueskyLexicon {
    /// Bluesky post record type
    public static let feedPost = "app.bsky.feed.post"

    /// Rich text link facet
    public static let richTextLink = "app.bsky.richtext.facet#link"

    /// Rich text mention facet
    public static let richTextMention = "app.bsky.richtext.facet#mention"

    /// Rich text hashtag facet
    public static let richTextTag = "app.bsky.richtext.facet#tag"
}
