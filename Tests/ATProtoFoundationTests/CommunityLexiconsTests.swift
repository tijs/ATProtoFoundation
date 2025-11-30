//
//  CommunityLexiconsTests.swift
//  ATProtoFoundation
//
//  Tests for community and Bluesky lexicon constants and models
//

import Foundation
import Testing
@testable import ATProtoFoundation

@Suite("Community Lexicons", .tags(.unit, .models))
struct CommunityLexiconsTests {

    // MARK: - Community Lexicon Constants

    @Test("Bookmark lexicon constant")
    func bookmarkConstant() {
        #expect(CommunityLexicon.bookmark == "community.lexicon.bookmarks.bookmark")
    }

    @Test("Calendar event lexicon constant")
    func calendarEventConstant() {
        #expect(CommunityLexicon.calendarEvent == "community.lexicon.calendar.event")
    }

    @Test("Calendar RSVP lexicon constant")
    func calendarRSVPConstant() {
        #expect(CommunityLexicon.calendarRSVP == "community.lexicon.calendar.rsvp")
    }

    @Test("Interaction like lexicon constant")
    func interactionLikeConstant() {
        #expect(CommunityLexicon.interactionLike == "community.lexicon.interaction.like")
    }

    @Test("Location geo lexicon constant")
    func locationGeoConstant() {
        #expect(CommunityLexicon.locationGeo == "community.lexicon.location.geo")
    }

    @Test("Location address lexicon constant")
    func locationAddressConstant() {
        #expect(CommunityLexicon.locationAddress == "community.lexicon.location.address")
    }

    @Test("Location Foursquare lexicon constant")
    func locationFoursquareConstant() {
        #expect(CommunityLexicon.locationFoursquare == "community.lexicon.location.fsq")
    }

    @Test("Location H3 lexicon constant")
    func locationH3Constant() {
        #expect(CommunityLexicon.locationH3 == "community.lexicon.location.hthree")
    }

    @Test("Web Monetization lexicon constant")
    func webMonetizationConstant() {
        #expect(CommunityLexicon.webMonetization == "community.lexicon.payments.webMonetization")
    }

    // MARK: - Bluesky Lexicon Constants

    @Test("Feed post lexicon constant")
    func feedPostConstant() {
        #expect(BlueskyLexicon.feedPost == "app.bsky.feed.post")
    }

    @Test("Rich text link lexicon constant")
    func richTextLinkConstant() {
        #expect(BlueskyLexicon.richTextLink == "app.bsky.richtext.facet#link")
    }

    @Test("Rich text mention lexicon constant")
    func richTextMentionConstant() {
        #expect(BlueskyLexicon.richTextMention == "app.bsky.richtext.facet#mention")
    }

    @Test("Rich text tag lexicon constant")
    func richTextTagConstant() {
        #expect(BlueskyLexicon.richTextTag == "app.bsky.richtext.facet#tag")
    }

    // MARK: - Extensibility Tests

    @Test("Lexicon constants are stable strings")
    func lexiconConstantsAreStableStrings() {
        // These should never change - they're protocol identifiers
        #expect(CommunityLexicon.locationGeo == "community.lexicon.location.geo")
        #expect(CommunityLexicon.locationAddress == "community.lexicon.location.address")
        #expect(BlueskyLexicon.feedPost == "app.bsky.feed.post")
    }
}

// MARK: - Bookmark Model Tests

@Suite("Bookmark Model", .tags(.unit, .models))
struct BookmarkModelTests {

    @Test("Bookmark initialization")
    func bookmarkInit() {
        let bookmark = Bookmark(subject: "https://example.com", tags: ["news", "tech"])
        #expect(bookmark.type == CommunityLexicon.bookmark)
        #expect(bookmark.subject == "https://example.com")
        #expect(bookmark.tags == ["news", "tech"])
    }

    @Test("Bookmark encoding and decoding")
    func bookmarkCodable() throws {
        let bookmark = Bookmark(subject: "https://example.com", createdAt: Date(timeIntervalSince1970: 0), tags: ["test"])

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(bookmark)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(Bookmark.self, from: data)

        #expect(decoded.subject == bookmark.subject)
        #expect(decoded.tags == bookmark.tags)
        #expect(decoded.type == CommunityLexicon.bookmark)
    }
}

// MARK: - Calendar Model Tests

@Suite("Calendar Models", .tags(.unit, .models))
struct CalendarModelTests {

    @Test("CalendarEvent initialization")
    func calendarEventInit() {
        let event = CalendarEvent(
            name: "Swift Meetup",
            description: "Monthly Swift developers meetup",
            mode: .inPerson,
            status: .scheduled
        )
        #expect(event.type == CommunityLexicon.calendarEvent)
        #expect(event.name == "Swift Meetup")
        #expect(event.description == "Monthly Swift developers meetup")
        #expect(event.mode == .inPerson)
        #expect(event.status == .scheduled)
    }

    @Test("CalendarEventMode raw values")
    func calendarEventModeRawValues() {
        #expect(CalendarEventMode.virtual.rawValue == "community.lexicon.calendar.event#virtual")
        #expect(CalendarEventMode.inPerson.rawValue == "community.lexicon.calendar.event#inperson")
        #expect(CalendarEventMode.hybrid.rawValue == "community.lexicon.calendar.event#hybrid")
    }

    @Test("CalendarEventStatus raw values")
    func calendarEventStatusRawValues() {
        #expect(CalendarEventStatus.planned.rawValue == "community.lexicon.calendar.event#planned")
        #expect(CalendarEventStatus.scheduled.rawValue == "community.lexicon.calendar.event#scheduled")
        #expect(CalendarEventStatus.rescheduled.rawValue == "community.lexicon.calendar.event#rescheduled")
        #expect(CalendarEventStatus.cancelled.rawValue == "community.lexicon.calendar.event#cancelled")
        #expect(CalendarEventStatus.postponed.rawValue == "community.lexicon.calendar.event#postponed")
    }

    @Test("RSVPStatus raw values")
    func rsvpStatusRawValues() {
        #expect(RSVPStatus.interested.rawValue == "community.lexicon.calendar.rsvp#interested")
        #expect(RSVPStatus.going.rawValue == "community.lexicon.calendar.rsvp#going")
        #expect(RSVPStatus.notGoing.rawValue == "community.lexicon.calendar.rsvp#notgoing")
    }

    @Test("CalendarRSVP initialization")
    func calendarRSVPInit() {
        let subject = StrongRef(uri: "at://did:plc:test/community.lexicon.calendar.event/abc123", cid: "bafytest")
        let rsvp = CalendarRSVP(subject: subject, status: .going)
        #expect(rsvp.type == CommunityLexicon.calendarRSVP)
        #expect(rsvp.status == .going)
        #expect(rsvp.subject.uri == subject.uri)
    }

    @Test("CalendarEventURI initialization")
    func calendarEventURIInit() {
        let uri = CalendarEventURI(uri: "https://zoom.us/j/123456", name: "Zoom Link")
        #expect(uri.uri == "https://zoom.us/j/123456")
        #expect(uri.name == "Zoom Link")
    }

    @Test("CalendarEvent encoding and decoding")
    func calendarEventCodable() throws {
        let event = CalendarEvent(
            name: "Test Event",
            createdAt: Date(timeIntervalSince1970: 0),
            mode: .hybrid,
            status: .planned
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(event)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(CalendarEvent.self, from: data)

        #expect(decoded.name == event.name)
        #expect(decoded.mode == .hybrid)
        #expect(decoded.status == .planned)
    }
}

// MARK: - Interaction Model Tests

@Suite("Interaction Models", .tags(.unit, .models))
struct InteractionModelTests {

    @Test("InteractionLike initialization")
    func interactionLikeInit() {
        let subject = StrongRef(uri: "at://did:plc:test/app.bsky.feed.post/abc123", cid: "bafytest")
        let like = InteractionLike(subject: subject)
        #expect(like.type == CommunityLexicon.interactionLike)
        #expect(like.subject.uri == subject.uri)
        #expect(like.subject.cid == subject.cid)
    }

    @Test("InteractionLike encoding and decoding")
    func interactionLikeCodable() throws {
        let subject = StrongRef(uri: "at://did:plc:test/app.bsky.feed.post/abc123", cid: "bafytest")
        let like = InteractionLike(subject: subject, createdAt: Date(timeIntervalSince1970: 0))

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(like)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(InteractionLike.self, from: data)

        #expect(decoded.subject.uri == like.subject.uri)
        #expect(decoded.type == CommunityLexicon.interactionLike)
    }
}

// MARK: - Location Model Tests

@Suite("Location Models", .tags(.unit, .models))
struct LocationModelTests {

    @Test("GeoCoordinates initialization")
    func geoCoordinatesInit() {
        let geo = GeoCoordinates(latitude: 37.7749, longitude: -122.4194, altitude: 10.5, name: "San Francisco")
        #expect(geo.type == CommunityLexicon.locationGeo)
        #expect(geo.latitudeValue == 37.7749)
        #expect(geo.longitudeValue == -122.4194)
        #expect(geo.altitudeValue == 10.5)
        #expect(geo.name == "San Francisco")
    }

    @Test("GeoCoordinates encoding and decoding")
    func geoCoordinatesCodable() throws {
        let geo = GeoCoordinates(latitude: 40.7128, longitude: -74.0060)
        let data = try JSONEncoder().encode(geo)
        let decoded = try JSONDecoder().decode(GeoCoordinates.self, from: data)
        #expect(decoded.latitudeValue == 40.7128)
        #expect(decoded.longitudeValue == -74.0060)
    }

    @Test("CommunityAddress initialization")
    func communityAddressInit() {
        let address = CommunityAddress(
            country: "US",
            postalCode: "94102",
            region: "CA",
            locality: "San Francisco",
            street: "123 Main St",
            name: "Office"
        )
        #expect(address.type == CommunityLexicon.locationAddress)
        #expect(address.country == "US")
        #expect(address.postalCode == "94102")
        #expect(address.region == "CA")
        #expect(address.locality == "San Francisco")
        #expect(address.street == "123 Main St")
        #expect(address.name == "Office")
    }

    @Test("CommunityAddress encoding and decoding")
    func communityAddressCodable() throws {
        let address = CommunityAddress(country: "NL", locality: "Amsterdam")
        let data = try JSONEncoder().encode(address)
        let decoded = try JSONDecoder().decode(CommunityAddress.self, from: data)
        #expect(decoded.country == "NL")
        #expect(decoded.locality == "Amsterdam")
    }

    @Test("FoursquareLocation initialization")
    func foursquareLocationInit() {
        let fsq = FoursquareLocation(
            fsqPlaceId: "4b8c3d87f964a520f7c532e3",
            latitude: 37.7749,
            longitude: -122.4194,
            name: "Golden Gate Park"
        )
        #expect(fsq.type == CommunityLexicon.locationFoursquare)
        #expect(fsq.fsqPlaceId == "4b8c3d87f964a520f7c532e3")
        #expect(fsq.latitudeValue == 37.7749)
        #expect(fsq.longitudeValue == -122.4194)
        #expect(fsq.name == "Golden Gate Park")
    }

    @Test("FoursquareLocation encoding and decoding")
    func foursquareLocationCodable() throws {
        let fsq = FoursquareLocation(fsqPlaceId: "abc123")
        let data = try JSONEncoder().encode(fsq)
        let decoded = try JSONDecoder().decode(FoursquareLocation.self, from: data)
        #expect(decoded.fsqPlaceId == "abc123")
    }

    @Test("H3Location initialization")
    func h3LocationInit() {
        let h3 = H3Location(value: "8928308280fffff", name: "Downtown")
        #expect(h3.type == CommunityLexicon.locationH3)
        #expect(h3.value == "8928308280fffff")
        #expect(h3.name == "Downtown")
    }

    @Test("H3Location encoding and decoding")
    func h3LocationCodable() throws {
        let h3 = H3Location(value: "8928308280fffff")
        let data = try JSONEncoder().encode(h3)
        let decoded = try JSONDecoder().decode(H3Location.self, from: data)
        #expect(decoded.value == "8928308280fffff")
    }
}

// MARK: - Payments Model Tests

@Suite("Payments Models", .tags(.unit, .models))
struct PaymentsModelTests {

    @Test("WebMonetizationWallet initialization")
    func webMonetizationWalletInit() {
        let wallet = WebMonetizationWallet(
            address: "https://ilp.uphold.com/abc123",
            note: "Primary donation wallet"
        )
        #expect(wallet.type == CommunityLexicon.webMonetization)
        #expect(wallet.address == "https://ilp.uphold.com/abc123")
        #expect(wallet.note == "Primary donation wallet")
    }

    @Test("WebMonetizationWallet encoding and decoding")
    func webMonetizationWalletCodable() throws {
        let wallet = WebMonetizationWallet(address: "https://pay.example.com/wallet")
        let data = try JSONEncoder().encode(wallet)
        let decoded = try JSONDecoder().decode(WebMonetizationWallet.self, from: data)
        #expect(decoded.address == wallet.address)
        #expect(decoded.type == CommunityLexicon.webMonetization)
    }
}

// MARK: - Rich Text Model Tests

@Suite("Rich Text Models", .tags(.unit, .models))
struct RichTextModelTests {

    @Test("RichTextFacet creation")
    func richTextFacetCreation() {
        let byteRange = ByteRange(byteStart: 0, byteEnd: 10)
        let linkFeature = RichTextFeature.link(uri: "https://example.com")

        let facet = RichTextFacet(index: byteRange, features: [linkFeature])

        #expect(facet.index.byteStart == 0)
        #expect(facet.index.byteEnd == 10)
        #expect(facet.features.count == 1)
    }

    @Test("ByteRange initialization")
    func byteRangeInit() {
        let range = ByteRange(byteStart: 5, byteEnd: 15)
        #expect(range.byteStart == 5)
        #expect(range.byteEnd == 15)
    }

    @Test("RichTextFeature link encoding and decoding")
    func richTextFeatureLinkCodable() throws {
        let feature = RichTextFeature.link(uri: "https://example.com")

        let jsonData = try JSONEncoder().encode(feature)
        let decoded = try JSONDecoder().decode(RichTextFeature.self, from: jsonData)

        if case let .link(uri) = decoded {
            #expect(uri == "https://example.com")
        } else {
            Issue.record("Expected link feature")
        }
    }

    @Test("RichTextFeature mention encoding and decoding")
    func richTextFeatureMentionCodable() throws {
        let feature = RichTextFeature.mention(did: "did:plc:test123")

        let jsonData = try JSONEncoder().encode(feature)
        let decoded = try JSONDecoder().decode(RichTextFeature.self, from: jsonData)

        if case let .mention(did) = decoded {
            #expect(did == "did:plc:test123")
        } else {
            Issue.record("Expected mention feature")
        }
    }

    @Test("RichTextFeature tag encoding and decoding")
    func richTextFeatureTagCodable() throws {
        let feature = RichTextFeature.tag(tag: "climbing")

        let jsonData = try JSONEncoder().encode(feature)
        let decoded = try JSONDecoder().decode(RichTextFeature.self, from: jsonData)

        if case let .tag(tag) = decoded {
            #expect(tag == "climbing")
        } else {
            Issue.record("Expected tag feature")
        }
    }

    @Test("RichTextFeature encodes with correct $type")
    func richTextFeatureEncodesType() throws {
        let linkFeature = RichTextFeature.link(uri: "https://example.com")
        let mentionFeature = RichTextFeature.mention(did: "did:plc:test")
        let tagFeature = RichTextFeature.tag(tag: "test")

        let linkData = try JSONEncoder().encode(linkFeature)
        let mentionData = try JSONEncoder().encode(mentionFeature)
        let tagData = try JSONEncoder().encode(tagFeature)

        let linkJson = try JSONSerialization.jsonObject(with: linkData) as? [String: Any]
        let mentionJson = try JSONSerialization.jsonObject(with: mentionData) as? [String: Any]
        let tagJson = try JSONSerialization.jsonObject(with: tagData) as? [String: Any]

        #expect(linkJson?["$type"] as? String == BlueskyLexicon.richTextLink)
        #expect(mentionJson?["$type"] as? String == BlueskyLexicon.richTextMention)
        #expect(tagJson?["$type"] as? String == BlueskyLexicon.richTextTag)
    }
}
