import Foundation

// MARK: - Payments Lexicon Models

/// A Web Monetization wallet record.
///
/// Conforms to `community.lexicon.payments.webMonetization`
/// See: https://webmonetization.org/
public struct WebMonetizationWallet: Codable, Sendable, Hashable {
    /// The lexicon type identifier
    public let type: String

    /// The wallet address (URI format)
    public let address: String

    /// Optional human-readable description of how this wallet relates to the account
    public let note: String?

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
        case address
        case note
    }

    public init(address: String, note: String? = nil) {
        self.type = CommunityLexicon.webMonetization
        self.address = address
        self.note = note
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
            ?? CommunityLexicon.webMonetization
        self.address = try container.decode(String.self, forKey: .address)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
    }
}
