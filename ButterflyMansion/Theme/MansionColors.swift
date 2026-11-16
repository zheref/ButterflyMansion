//
//  MansionColors.swift
//  ButterflyMansion
//
//  Color tokens evoking the Butterfly Mansion (Kocho Estate) from
//  Demon Slayer: wisteria purple, sakura pink, and insect-wing teal,
//  set against warm washi-paper neutrals.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color {
    /// A color that adapts between light and dark appearance.
    static func adaptive(light: Color, dark: Color) -> Color {
        #if canImport(UIKit)
        return Color(UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
        #elseif canImport(AppKit)
        return Color(NSColor(name: nil) { appearance in
            let isDark = appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua
            return NSColor(isDark ? dark : light)
        })
        #else
        return light
        #endif
    }

    init(hex: UInt32, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}

/// Raw palette and semantic design tokens for the Butterfly Mansion theme.
/// Decoupled from any specific view so it can be reused across the app.
enum MansionPalette {

    // MARK: Wisteria (primary) — Shinobu Kocho's signature purple
    //
    // wisteria400 is mirrored in Assets.xcassets/AccentColor so the
    // system-level accent color (keyboards, control selection, etc.)
    // matches this token too — keep the two in sync if it changes.

    static let wisteria100 = Color(hex: 0xF3EDF8)
    static let wisteria200 = Color(hex: 0xD9C8EC)
    static let wisteria400 = Color(hex: 0x9B7FC7)
    static let wisteria600 = Color(hex: 0x6B4F9E)
    static let wisteria800 = Color(hex: 0x4A3569)

    // MARK: Sakura (secondary) — soft butterfly-wing pink

    static let sakura100 = Color(hex: 0xFBE4EA)
    static let sakura300 = Color(hex: 0xF3B8CB)
    static let sakura500 = Color(hex: 0xE78FAE)
    static let sakura700 = Color(hex: 0xC15F82)

    // MARK: Teal (accent) — insect-wing teal

    static let teal100 = Color(hex: 0xE1F5F0)
    static let teal300 = Color(hex: 0x9FDDD2)
    static let teal500 = Color(hex: 0x4FB8AA)
    static let teal700 = Color(hex: 0x2F8A80)

    // MARK: Gold (rare highlight) — kanzashi hairpin accent

    static let gold500 = Color(hex: 0xD8B468)

    // MARK: Neutrals — washi paper & ink

    static let paperLight = Color(hex: 0xFBF6F3)
    static let paperDark = Color(hex: 0x211A28)
    static let surfaceLight = Color(hex: 0xFFFFFF)
    static let surfaceDark = Color(hex: 0x2E2435)
    static let inkLight = Color(hex: 0x3B2E3F)
    static let inkDark = Color(hex: 0xF3E9EE)
    static let inkSoftLight = Color(hex: 0x6E5D6E)
    static let inkSoftDark = Color(hex: 0xC9B8C7)
    static let borderLight = Color(hex: 0xE7DCE6)
    static let borderDark = Color(hex: 0x42324A)
}

/// Semantic tokens other code should reach for. Prefer these over
/// `MansionPalette` directly so the meaning of a color stays obvious
/// at the call site and the palette can evolve independently.
extension Color {
    static let mansionPrimary = Color.adaptive(light: MansionPalette.wisteria400, dark: MansionPalette.wisteria400)
    static let mansionPrimaryDeep = Color.adaptive(light: MansionPalette.wisteria600, dark: MansionPalette.wisteria200)
    static let mansionPrimarySoft = Color.adaptive(light: MansionPalette.wisteria100, dark: MansionPalette.wisteria800)

    static let mansionSecondary = Color.adaptive(light: MansionPalette.sakura500, dark: MansionPalette.sakura300)
    static let mansionSecondarySoft = Color.adaptive(light: MansionPalette.sakura100, dark: MansionPalette.sakura700)

    static let mansionAccent = Color.adaptive(light: MansionPalette.teal500, dark: MansionPalette.teal300)
    static let mansionAccentSoft = Color.adaptive(light: MansionPalette.teal100, dark: MansionPalette.teal700)

    static let mansionGold = MansionPalette.gold500

    static let mansionBackground = Color.adaptive(light: MansionPalette.paperLight, dark: MansionPalette.paperDark)
    static let mansionSurface = Color.adaptive(light: MansionPalette.surfaceLight, dark: MansionPalette.surfaceDark)
    static let mansionTextPrimary = Color.adaptive(light: MansionPalette.inkLight, dark: MansionPalette.inkDark)
    static let mansionTextSecondary = Color.adaptive(light: MansionPalette.inkSoftLight, dark: MansionPalette.inkSoftDark)
    static let mansionBorder = Color.adaptive(light: MansionPalette.borderLight, dark: MansionPalette.borderDark)
}

extension LinearGradient {
    /// The signature wisteria-to-sakura wash used for headers and primary surfaces.
    static let mansionWisteriaWash = LinearGradient(
        colors: [MansionPalette.wisteria400, MansionPalette.sakura300],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    /// A deeper wash for pressed/filled states.
    static let mansionDeepWash = LinearGradient(
        colors: [MansionPalette.wisteria600, MansionPalette.wisteria800],
        startPoint: .top,
        endPoint: .bottom
    )
}
