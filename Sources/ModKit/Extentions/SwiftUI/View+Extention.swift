//
//  View+Extention.swift
//  ModKit
//
//  Created by Siva Sankar on 16/05/25.
//

import SwiftUI

extension View {

    //MARK:  - Colors
    public func foregroundColor(_ color: Color) -> some View {
        foregroundStyle(color)
    }

    public func backgroundColor(_ color: Color) -> some View {
        backgroundStyle(color)
    }

    //MARK: - Custom Modifiers
    /// Applies a custom view style with optional corner radius, border, and corner-specific styling.
    ///
    /// - Parameters:
    ///   - radius: A uniform corner radius applied to all corners if provided.
    ///   - topLeadingRadius: The radius for the top-left corner.
    ///   - topTrailingRadius: The radius for the top-right corner.
    ///   - bottomLeadingRadius: The radius for the bottom-left corner.
    ///   - bottomTrailingRadius: The radius for the bottom-right corner.
    ///   - radiusStyle: The style of the corner radius (e.g., `.circular` or `.continuous`).
    ///   - borderColor: The color of the border. Defaults to `.clear`.
    ///   - borderWidth: The width of the border. Defaults to `0`.
    /// - Returns: A view with the applied custom styling.
    public func style(
        radius: CGFloat? = nil,
        topLeadingRadius: CGFloat = 0,
        topTrailingRadius: CGFloat = 0,
        bottomLeadingRadius: CGFloat = 0,
        bottomTrailingRadius: CGFloat = 0,
        radiusStyle: RoundedCornerStyle = .continuous,
        borderColor: Color = .clear,
        borderWidth: CGFloat = 0
    ) -> some View {
        modifier(
            ViewStyle(
                radius: radius,
                topLeadingRadius: topLeadingRadius,
                topTrailingRadius: topTrailingRadius,
                bottomLeadingRadius: bottomLeadingRadius,
                bottomTrailingRadius: bottomTrailingRadius,
                radiusStyle: radiusStyle,
                borderColor: borderColor,
                borderWidth: borderWidth
            )
        )
    }

    /// Applies a uniform corner radius to all corners of the view.
    ///
    /// - Parameter radius: The radius to apply to all corners. Defaults to `0`.
    /// - Returns: A view with rounded corners.
    public func cornerRadius(_ radius: CGFloat = 0) -> some View {
        clipShape(.rect(cornerRadius: radius))
    }

    /// Applies corner radii to each corner individually with a specified radius style.
    ///
    /// - Parameters:
    ///   - topLeadingRadius: The radius for the top-left corner.
    ///   - topTrailingRadius: The radius for the top-right corner.
    ///   - bottomLeadingRadius: The radius for the bottom-left corner.
    ///   - bottomTrailingRadius: The radius for the bottom-right corner.
    ///   - radiusStyle: The style of the corner radius (e.g., `.circular` or `.continuous`). Defaults to `.continuous`.
    /// - Returns: A view with individually rounded corners.
    public func cornerRadius(
        topLeadingRadius: CGFloat = 0,
        topTrailingRadius: CGFloat = 0,
        bottomLeadingRadius: CGFloat = 0,
        bottomTrailingRadius: CGFloat = 0,
        radiusStyle: RoundedCornerStyle = .continuous
    ) -> some View {
        clipShape(.rect(topLeadingRadius: topLeadingRadius, bottomLeadingRadius: bottomLeadingRadius, bottomTrailingRadius: bottomTrailingRadius, topTrailingRadius: topTrailingRadius, style: radiusStyle))
    }

    /// Applies a border to the view with specified color and width.
    ///
    /// - Parameters:
    ///   - color: The border color. Defaults to `.accentColor`.
    ///   - width: The border width. Defaults to `1`.
    /// - Returns: A view with the applied border.
    public func borderStyle(color: Color = .accentColor, width: CGFloat = 1)
        -> some View
    {
        modifier(ViewStyle(borderColor: color, borderWidth: width))
    }

    //MARK: - Padding
    /// Applies default horizontal padding to the view.
    ///
    /// Equivalent to `.padding(.horizontal)`.
    ///
    /// - Returns: A view with horizontal padding applied.
    public func horizontalPadding() -> some View {
        padding(.horizontal)
    }

    /// Applies horizontal padding with a specific value to the view.
    ///
    /// - Parameter value: The amount of horizontal padding to apply.
    /// - Returns: A view with the specified horizontal padding.
    public func horizontalPadding(_ value: CGFloat) -> some View {
        padding(.horizontal, value)
    }

    /// Applies default vertical padding to the view.
    ///
    /// Equivalent to `.padding(.vertical)`.
    ///
    /// - Returns: A view with vertical padding applied.
    public func verticalPadding() -> some View {
        padding(.vertical)
    }

    /// Applies vertical padding with a specific value to the view.
    ///
    /// - Parameter value: The amount of vertical padding to apply.
    /// - Returns: A view with the specified vertical padding.
    public func verticalPadding(_ value: CGFloat) -> some View {
        padding(.vertical, value)
    }

    //MARK: - Frame

    public func frame(_ size: CGSize, _ alignment: Alignment = .center)
        -> some View
    {
        frame(width: size.width, height: size.height, alignment: alignment)
    }

    public func width(_ width: CGFloat, _ alignment: Alignment = .center)
        -> some View
    {
        frame(width: width, alignment: alignment)
    }

    public func height(_ height: CGFloat, _ alignment: Alignment = .center)
        -> some View
    {
        frame(height: height, alignment: alignment)
    }

    public func frame(_ size: CGFloat, _ alignment: Alignment = .center)
        -> some View
    {
        frame(width: size, height: size, alignment: alignment)
    }

    public func maxHeight(_ alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }

    public func maxWidth(_ alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }

    public func maxFrame(_ alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }

    // MARK: - Debugging

    /// Add a colored border for layout debugging
    public func debugBorder(_ color: Color = .red) -> some View {
        #if DEBUG
            return self.border(color, width: 1)
        #else
            return self
        #endif
    }

    /// Print the view's size to console for debugging
    public func debugSize(_ identifier: String = "") -> some View {
        #if DEBUG
            return background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            print("[\(identifier)] View size: \(geometry.size)")
                        }
                        .onChange(of: geometry.size) { newSize in
                            print(
                                "[\(identifier)] View size changed: \(newSize)"
                            )
                        }
                }
            )
        #else
            return self
        #endif
    }

    // MARK: - Tap Gestures

    /// Add a tap gesture that executes different actions for single, double and long press
    public func multiTapGesture(
        onSingleTap: @escaping () -> Void,
        onDoubleTap: @escaping () -> Void,
        onLongPress: @escaping () -> Void
    ) -> some View {
        simultaneousGesture(
            TapGesture(count: 1)
                .onEnded { _ in onSingleTap() }
        )
        .simultaneousGesture(
            TapGesture(count: 2)
                .onEnded { _ in onDoubleTap() }
        )
        .simultaneousGesture(
            LongPressGesture()
                .onEnded { _ in onLongPress() }
        )
    }

    // MARK: - Conditional Modifiers

    /// Apply a modifier conditionally
    @ViewBuilder
    public func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// Apply different modifiers based on a condition
    @ViewBuilder
    public func ifElse<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        ifTransform: (Self) -> TrueContent,
        elseTransform: (Self) -> FalseContent
    ) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }

}
