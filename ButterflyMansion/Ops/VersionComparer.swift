//
//  VersionComparer.swift
//  ButterflyMansion
//
//  Created by Sergio Daniel on 11/15/26.
//

/// PROBLEM 1: Version String Comparison | |
/// Task: Given an array of semantic marketing version strings (e.g., ["1.10.0", "1.9.3", "1.2"]), | | return the latest valid version. | | Trap: Standard string comparison evaluates "1.10.0" &lt; "1.9.3" because '1' &lt; '9' character-wise. | | Solution Strategy: Parse into structured integer components, pad missing components with zero | | (e.g., "1.2" -&gt; [1, 2, 0]), implement Comparable, filter invalid strings via failable init. |
///

internal enum VersionComparer {
    
    typealias Version = (major: Int, minor: Int, patch: Int)
    static let NoVersion: Version = (major: 0, minor: 0, patch: 0)
    
    nonisolated static func stringToVersion(_ str: String) -> Version? {
        let parts = str.split(separator: ".").map(String.init)
        guard parts.count == 3 else {
            print("Warning: \(str) MUST have exactly 3 parts separated by dot")
            return nil
        }
        return (major: Int(parts[0]) ?? 0, minor: Int(parts[1]) ?? 0, patch: Int(parts[2]) ?? 0)
    }
    
    nonisolated static func versionToString(_ version: Version) -> String {
        return "\(version.major).\(version.minor).\(version.patch)"
    }
    
    static func getLatestValid(from versions: [String]) -> String {
        let greatest = versions
            .compactMap(stringToVersion)
            .sorted { $0 > $1 }
            .first ?? NoVersion
        return versionToString(greatest)
    }
    
    static func getLatestValidFrom(versions strs: [String]) -> String {
        let versions = strs.compactMap(stringToVersion)
        let sortedVersions = versions.sorted { $0 > $1 }
        let first = sortedVersions.first ?? NoVersion
        return versionToString(first)
    }
    
}
