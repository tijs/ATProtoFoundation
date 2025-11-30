import Foundation

// MARK: - Location Lexicon Models

/// Geographic coordinates using WGS84 format.
///
/// Conforms to `community.lexicon.location.geo`
public struct GeoCoordinates: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// Latitude as a string
    public let latitude: String

    /// Longitude as a string
    public let longitude: String

    /// Optional altitude as a string
    public let altitude: String?

    /// Optional name of the location
    public let name: String?

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case latitude
        case longitude
        case altitude
        case name
    }

    public init(latitude: Double, longitude: Double, altitude: Double? = nil, name: String? = nil) {
        self.type = CommunityLexicon.locationGeo
        self.latitude = String(latitude)
        self.longitude = String(longitude)
        self.altitude = altitude.map { String($0) }
        self.name = name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
            ?? CommunityLexicon.locationGeo
        self.latitude = try container.decode(String.self, forKey: .latitude)
        self.longitude = try container.decode(String.self, forKey: .longitude)
        self.altitude = try container.decodeIfPresent(String.self, forKey: .altitude)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    /// Convenience accessor for latitude as Double
    public var latitudeValue: Double? {
        Double(latitude)
    }

    /// Convenience accessor for longitude as Double
    public var longitudeValue: Double? {
        Double(longitude)
    }

    /// Convenience accessor for altitude as Double
    public var altitudeValue: Double? {
        altitude.flatMap { Double($0) }
    }
}

/// A physical address.
///
/// Conforms to `community.lexicon.location.address`
public struct CommunityAddress: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// ISO 3166 country code (preferably 2-letter)
    public let country: String

    /// Postal code
    public let postalCode: String?

    /// Administrative region (e.g., state in USA)
    public let region: String?

    /// Locality (e.g., city)
    public let locality: String?

    /// Street address
    public let street: String?

    /// Name of the location
    public let name: String?

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case country
        case postalCode
        case region
        case locality
        case street
        case name
    }

    public init(
        country: String,
        postalCode: String? = nil,
        region: String? = nil,
        locality: String? = nil,
        street: String? = nil,
        name: String? = nil
    ) {
        self.type = CommunityLexicon.locationAddress
        self.country = country
        self.postalCode = postalCode
        self.region = region
        self.locality = locality
        self.street = street
        self.name = name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
            ?? CommunityLexicon.locationAddress
        self.country = try container.decode(String.self, forKey: .country)
        self.postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
        self.locality = try container.decodeIfPresent(String.self, forKey: .locality)
        self.street = try container.decodeIfPresent(String.self, forKey: .street)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

/// A location from the Foursquare Open Source Places dataset.
///
/// Conforms to `community.lexicon.location.fsq`
public struct FoursquareLocation: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// The unique identifier of the Foursquare POI
    public let fsqPlaceId: String

    /// Optional latitude
    public let latitude: String?

    /// Optional longitude
    public let longitude: String?

    /// Optional name of the location
    public let name: String?

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case fsqPlaceId = "fsq_place_id"
        case latitude
        case longitude
        case name
    }

    public init(fsqPlaceId: String, latitude: Double? = nil, longitude: Double? = nil, name: String? = nil) {
        self.type = CommunityLexicon.locationFoursquare
        self.fsqPlaceId = fsqPlaceId
        self.latitude = latitude.map { String($0) }
        self.longitude = longitude.map { String($0) }
        self.name = name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
            ?? CommunityLexicon.locationFoursquare
        self.fsqPlaceId = try container.decode(String.self, forKey: .fsqPlaceId)
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    /// Convenience accessor for latitude as Double
    public var latitudeValue: Double? {
        latitude.flatMap { Double($0) }
    }

    /// Convenience accessor for longitude as Double
    public var longitudeValue: Double? {
        longitude.flatMap { Double($0) }
    }
}

/// A location in H3 encoded format.
///
/// Conforms to `community.lexicon.location.hthree`
public struct H3Location: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// The H3 encoded location value
    public let value: String

    /// Optional name of the location
    public let name: String?

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case value
        case name
    }

    public init(value: String, name: String? = nil) {
        self.type = CommunityLexicon.locationH3
        self.value = value
        self.name = name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
            ?? CommunityLexicon.locationH3
        self.value = try container.decode(String.self, forKey: .value)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}
