import XCTest
import CryptoSwift
@testable import BIP32

final class KeyFingerprintDerivatorTests: XCTestCase {
    private var testVectors: [KeyFingerprintTestVector]!

    override func setUpWithError() throws {
        testVectors = try JSONDecoder().decode([KeyFingerprintTestVector].self, from: keyFingerprintTestVectorData)
    }

    private func sut() -> KeyFingerprintDerivator {
        .init()
    }

    func testGivenVectors_WhenCount_ThenEqual5() {
        XCTAssertEqual(testVectors.count, 5)
    }

    func testGivenVectorPublicKey_WhenGenerateFingerprint_ThenEqualVectorFingerprint() throws {
        for testVector in testVectors {
            let publicKey = Data(hex: testVector.hexEncodedPublicKey)
            let fingerprintBytes = sut()
                .fingerprint(publicKey: publicKey)
                .bytes
            let expectedFingerprintBytes = UInt32(
                data: Data(hex: testVector.hexEncodedPublicKeyFingerprint)
            )!.bytes
            XCTAssertEqual(fingerprintBytes, expectedFingerprintBytes)
        }
    }
}