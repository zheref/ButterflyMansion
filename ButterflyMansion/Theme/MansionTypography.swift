//
//  MansionTypography.swift
//  ButterflyMansion
//
//  Type tokens for the Butterfly Mansion theme: an elegant serif for
//  display moments paired with a soft rounded voice for everyday UI,
//  echoing traditional calligraphy next to gentle, healing warmth.
//
//  All tokens are built from Dynamic Type text styles so sizes scale
//  automatically with the user's preferred reading size.
//

import SwiftUI

enum MansionFont {
    /// Large hero/display text — mansion name, section openers.
    static let display = Font.system(.largeTitle, design: .serif, weight: .semibold)

    /// Screen and sheet titles.
    static let title = Font.system(.title2, design: .serif, weight: .semibold)

    /// Section and card headers.
    static let headline = Font.system(.headline, design: .rounded, weight: .semibold)

    /// Default body copy.
    static let body = Font.system(.body, design: .rounded)

    /// Secondary, de-emphasized copy.
    static let subheadline = Font.system(.subheadline, design: .rounded)

    /// Buttons and tags.
    static let button = Font.system(.callout, design: .rounded, weight: .semibold)

    /// Fine print, timestamps, captions.
    static let caption = Font.system(.caption, design: .rounded, weight: .medium)
}

/// Convenience modifiers so views can apply a token plus its matching
/// semantic color in a single call, keeping call sites short.
extension View {
    func mansionDisplayText() -> some View {
        font(MansionFont.display).foregroundStyle(Color.mansionTextPrimary)
    }

    func mansionTitleText() -> some View {
        font(MansionFont.title).foregroundStyle(Color.mansionTextPrimary)
    }

    func mansionHeadlineText() -> some View {
        font(MansionFont.headline).foregroundStyle(Color.mansionTextPrimary)
    }

    func mansionBodyText() -> some View {
        font(MansionFont.body).foregroundStyle(Color.mansionTextPrimary)
    }

    func mansionSubheadlineText() -> some View {
        font(MansionFont.subheadline).foregroundStyle(Color.mansionTextSecondary)
    }

    func mansionCaptionText() -> some View {
        font(MansionFont.caption).foregroundStyle(Color.mansionTextSecondary)
    }
}
