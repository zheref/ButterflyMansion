//
//  MansionStyles.swift
//  ButterflyMansion
//
//  Reusable, decoupled building blocks — button styles, a card
//  modifier, an ambient background, and a small decorative butterfly
//  glyph — built on top of the Mansion color/typography/metric tokens.
//  Views opt in with `.buttonStyle(.mansionPrimary)`,
//  `.mansionCard()`, etc., without needing to know the token values.
//

import SwiftUI

// MARK: - Buttons

struct MansionPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(MansionFont.button)
            .foregroundStyle(.white)
            .padding(.horizontal, MansionSpacing.lg)
            .padding(.vertical, MansionSpacing.sm + 2)
            .background(LinearGradient.mansionWisteriaWash, in: Capsule())
            .opacity(configuration.isPressed ? 0.85 : 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct MansionSecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(MansionFont.button)
            .foregroundStyle(Color.mansionPrimaryDeep)
            .padding(.horizontal, MansionSpacing.lg)
            .padding(.vertical, MansionSpacing.sm + 2)
            .background(Color.mansionPrimarySoft, in: Capsule())
            .overlay(Capsule().strokeBorder(Color.mansionPrimary.opacity(0.35), lineWidth: 1))
            .opacity(configuration.isPressed ? 0.85 : 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == MansionPrimaryButtonStyle {
    static var mansionPrimary: MansionPrimaryButtonStyle { MansionPrimaryButtonStyle() }
}

extension ButtonStyle where Self == MansionSecondaryButtonStyle {
    static var mansionSecondary: MansionSecondaryButtonStyle { MansionSecondaryButtonStyle() }
}

// MARK: - Surfaces

private struct MansionCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(MansionSpacing.md)
            .background(Color.mansionSurface, in: RoundedRectangle(cornerRadius: MansionRadius.md, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: MansionRadius.md, style: .continuous)
                    .strokeBorder(Color.mansionBorder, lineWidth: 1)
            )
            .shadow(
                color: MansionShadow.soft.color,
                radius: MansionShadow.soft.radius,
                x: MansionShadow.soft.x,
                y: MansionShadow.soft.y
            )
    }
}

extension View {
    /// Wraps content in the theme's elevated "surface" card treatment.
    func mansionCard() -> some View {
        modifier(MansionCardModifier())
    }
}

/// A soft, layered wash evoking lantern-lit wisteria gardens at dusk.
/// Intended as a full-screen background behind content.
struct MansionBackground: View {
    var body: some View {
        ZStack {
            Color.mansionBackground
            RadialGradient(
                colors: [Color.mansionPrimarySoft.opacity(0.9), .clear],
                center: .topLeading,
                startRadius: 0,
                endRadius: 420
            )
            RadialGradient(
                colors: [Color.mansionSecondarySoft.opacity(0.7), .clear],
                center: .bottomTrailing,
                startRadius: 0,
                endRadius: 380
            )
        }
        .ignoresSafeArea()
    }
}

// MARK: - Decorative motif

/// A minimal, stylized butterfly silhouette built from primitive
/// shapes (no bespoke image assets required) for small decorative
/// accents — empty states, dividers, loading moments.
struct ButterflyGlyph: View {
    var tint: Color = .mansionAccent
    var size: CGFloat = 28

    var body: some View {
        HStack(spacing: size * 0.04) {
            wing.rotationEffect(.degrees(-18))
            wing.rotationEffect(.degrees(18)).scaleEffect(x: -1, y: 1)
        }
        .frame(width: size, height: size)
    }

    private var wing: some View {
        VStack(spacing: size * 0.03) {
            Ellipse().frame(width: size * 0.46, height: size * 0.56)
            Ellipse().frame(width: size * 0.32, height: size * 0.34)
        }
        .foregroundStyle(tint.gradient)
    }
}
