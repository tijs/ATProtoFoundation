import Foundation

// MARK: - StrongRef Models

/// AT Protocol StrongRef for referencing records with content integrity verification
public struct StrongRef: Codable, Sendable, Hashable {
    /// AT URI pointing to the referenced record
    public let uri: String

    /// CID (Content Identifier) for content integrity verification
    public let cid: String

    public init(uri: String, cid: String) {
        self.uri = uri
        self.cid = cid
    }
}

// MARK: - Error Types

public enum ATProtoError: LocalizedError, Sendable, Equatable {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError(Error)
    case authenticationFailed(String)
    case missingCredentials

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid AT Protocol URL"
        case .invalidResponse:
            "Invalid response from AT Protocol server"
        case let .httpError(code):
            "HTTP error \(code) from AT Protocol server"
        case let .decodingError(error):
            "Failed to decode AT Protocol response: \(error.localizedDescription)"
        case let .authenticationFailed(message):
            "AT Protocol authentication failed: \(message)"
        case .missingCredentials:
            "Missing or invalid AT Protocol credentials"
        }
    }

    public static func == (lhs: ATProtoError, rhs: ATProtoError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse),
             (.missingCredentials, .missingCredentials):
            return true
        case let (.httpError(lhsCode), .httpError(rhsCode)):
            return lhsCode == rhsCode
        case let (.authenticationFailed(lhsMessage), .authenticationFailed(rhsMessage)):
            return lhsMessage == rhsMessage
        case let (.decodingError(lhsError), .decodingError(rhsError)):
            // Compare error descriptions since Error doesn't conform to Equatable
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
