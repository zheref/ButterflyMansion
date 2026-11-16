//
//  MansionMetrics.swift
//  ButterflyMansion
//
//  Spacing, radius, and shadow tokens shared across the theme so
//  layout rhythm stays consistent without hard-coded magic numbers.
//

import SwiftUI

enum MansionSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}

enum MansionRadius {
    static let sm: CGFloat = 10
    static let md: CGFloat = 18
    static let lg: CGFloat = 28
    static let pill: CGFloat = 999
}

enum MansionShadow {
    /// A soft, wisteria-tinted shadow for elevated cards and buttons.
    static let soft = (color: Color.mansionPrimary.opacity(0.18), radius: CGFloat(14), x: CGFloat(0), y: CGFloat(6))
}
