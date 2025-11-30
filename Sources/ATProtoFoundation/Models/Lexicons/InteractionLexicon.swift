import Foundation

// MARK: - Interaction Lexicon Models

/// A 'like' interaction with another AT Protocol record.
///
/// Conforms to `community.lexicon.interaction.like`
public struct InteractionLike: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// Reference to the record being liked
    public let subject: StrongRef

    /// When the like was created
    public let createdAt: Date

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case subject
        case createdAt
    }

    public init(subject: StrongRef, createdAt: Date = Date()) {
        self.type = CommunityLexicon.interactionLike
        self.subject = subject
        self.createdAt = createdAt
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
            ?? CommunityLexicon.interactionLike
        self.subject = try container.decode(StrongRef.self, forKey: .subject)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
}
