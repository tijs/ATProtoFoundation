@testable import ATProtoFoundation
import Foundation
import Testing

@Suite("AT Protocol Models", .tags(.models))
struct ATProtoModelsTests {
    // MARK: - StrongRef Tests

    @Test("StrongRef creation with valid URI and CID")
    func strongRefCreation() throws {
        let uri = "at://did:plc:test123/app.dropanchor.checkin/abc123"
        let cid = "bafyreid1234567890"

        let strongRef = StrongRef(uri: uri, cid: cid)

        #expect(strongRef.uri == uri)
        #expect(strongRef.cid == cid)
    }

    @Test("StrongRef Codable conformance")
    func strongRefCodableConformance() throws {
        let strongRef = StrongRef(
            uri: "at://did:plc:test123/app.dropanchor.checkin/abc123",
            cid: "bafyreid1234567890"
        )

        let jsonData = try JSONEncoder().encode(strongRef)
        let decoded = try JSONDecoder().decode(StrongRef.self, from: jsonData)

        #expect(decoded.uri == strongRef.uri)
        #expect(decoded.cid == strongRef.cid)
    }

    // MARK: - Error Tests

    @Test("ATProtoError equality")
    func atProtoErrorEquality() throws {
        let error1 = ATProtoError.httpError(404)
        let error2 = ATProtoError.httpError(404)
        let error3 = ATProtoError.httpError(500)

        #expect(error1 == error2)
        #expect(error1 != error3)
    }
}
