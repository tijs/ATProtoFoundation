import Foundation

// MARK: - Bookmarks Lexicon Models

/// A bookmark record for saving links to come back to later.
///
/// Conforms to `community.lexicon.bookmarks.bookmark`
public struct Bookmark: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// The URI being bookmarked
    public let subject: String

    /// When the bookmark was created
    public let createdAt: Date

    /// Optional tags for categorizing the bookmark
    public let tags: [String]?

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case subject
        case createdAt
        case tags
    }

    public init(subject: String, createdAt: Date = Date(), tags: [String]? = nil) {
        self.type = CommunityLexicon.bookmark
        self.subject = subject
        self.createdAt = createdAt
        self.tags = tags
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? CommunityLexicon.bookmark
        self.subject = try container.decode(String.self, forKey: .subject)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags)
    }
}
