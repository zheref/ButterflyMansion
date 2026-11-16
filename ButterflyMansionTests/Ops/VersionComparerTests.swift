//
//  VersionComparerTests.swift
//  ButterflyMansionTests
//
//  Created by Sergio Daniel on 11/15/26.
//

@testable import ButterflyMansion
import Testing

struct VersionComparerTests {

    @Test func testGetLatestValid() throws {
        // Given
        let someVersions: [String] = ["1.9.3", "1.10.0", "1.1.9", "1.0.6", "1.7.5", "1.2"]
        
        // When
//        let greatestValidVersion = VersionComparer.getLatestValid(from: someVersions)
        let greatestValidVersion = VersionComparer.getLatestValidFrom(versions: someVersions)
        
        // Then
        #expect(greatestValidVersion == "1.10.0")
    }

}
