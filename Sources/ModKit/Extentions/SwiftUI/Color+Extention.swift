//
//  Color+Extention.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import SwiftUI

extension Color {
    
    //MARK: - Core Graphics Colors
    public static let cgRed = Color(red: 1, green: 0, blue: 0)
    public static let cgGreen = Color(red: 0, green: 1, blue: 0)
    public static let cgBlue = Color(red: 0, green: 0, blue: 1)
    public static let cgYellow = Color(red: 1, green: 1, blue: 0)
    public static let cgMagenta = Color(red: 1, green: 0, blue: 1)
    public static let cgOrange = Color(red: 1, green: 0.5, blue: 0)
    public static let cgPurple = Color(red: 0.5, green: 0, blue: 0.5)
    public static let cgCyan = Color(red: 0, green: 1, blue: 1)
    public static let cgBrown = Color(red: 0.6, green: 0.4, blue: 0.2)
    public static let cgGray = Color(white: 0.5)
    public static let cgLightGray = Color(white: 0.667)
    public static let cgDarkGray = Color(white: 0.333)
    
    // Initialize with hex value
    public init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }

    // Initialize with hex string
    public init?(hexString: String, alpha: Double = 1) {
        var hexSanitized = hexString.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(
            .sRGB,
            red: Double((rgb >> 16) & 0xff) / 255,
            green: Double((rgb >> 8) & 0xff) / 255,
            blue: Double(rgb & 0xff) / 255,
            opacity: alpha
        )
    }

    // Generate a lighter color
    public func lighter(by percentage: CGFloat = 30.0) -> Color {
        return self.opacity(1.0 - percentage / 100)
    }

    // Generate a darker color
    public func darker(by percentage: CGFloat = 30.0) -> Color {
        return self.opacity(1.0 + percentage / 100)
    }
    public static func white(
        _ white: Double,
        opacity: Double = 1,
        _ colorSpace: Color.RGBColorSpace = .sRGB
    ) -> Color {
        Color(colorSpace, white: white, opacity: opacity)
    }
}
