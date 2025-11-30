import Foundation

// MARK: - Rich Text Lexicon Models

/// Represents a facet (rich text annotation) in AT Protocol
///
/// Facets annotate ranges of text with features like links, mentions, or hashtags.
/// Uses byte indices as required by the AT Protocol specification.
public struct RichTextFacet: Codable, Sendable {
    /// Byte index range in the text
    public let index: ByteRange

    /// The features for this facet (typically one feature per facet)
    public let features: [RichTextFeature]

    public init(index: ByteRange, features: [RichTextFeature]) {
        self.index = index
        self.features = features
    }
}

/// Byte range for facet positions in AT Protocol
///
/// AT Protocol uses byte offsets (not character offsets) for facet positions.
/// This is important for proper handling of multi-byte Unicode characters.
public struct ByteRange: Codable, Sendable {
    /// Starting byte offset (inclusive)
    public let byteStart: Int

    /// Ending byte offset (exclusive)
    public let byteEnd: Int

    public init(byteStart: Int, byteEnd: Int) {
        self.byteStart = byteStart
        self.byteEnd = byteEnd
    }
}

/// Different types of rich text features supported by AT Protocol
///
/// Features describe what a facet represents and are encoded with `$type` for JSON serialization.
public enum RichTextFeature: Codable, Sendable {
    case link(uri: String)
    case mention(did: String)
    case tag(tag: String)

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case uri, did, tag
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .link(uri):
            try container.encode(BlueskyLexicon.richTextLink, forKey: .type)
            try container.encode(uri, forKey: .uri)
        case let .mention(did):
            try container.encode(BlueskyLexicon.richTextMention, forKey: .type)
            try container.encode(did, forKey: .did)
        case let .tag(tag):
            try container.encode(BlueskyLexicon.richTextTag, forKey: .type)
            try container.encode(tag, forKey: .tag)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case BlueskyLexicon.richTextLink:
            let uri = try container.decode(String.self, forKey: .uri)
            self = .link(uri: uri)
        case BlueskyLexicon.richTextMention:
            let did = try container.decode(String.self, forKey: .did)
            self = .mention(did: did)
        case BlueskyLexicon.richTextTag:
            let tag = try container.decode(String.self, forKey: .tag)
            self = .tag(tag: tag)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown rich text feature type: \(type)"
                )
            )
        }
    }
}
