//
//  ViewStyle.swift
//  ModKit
//
//  Created by Siva Sankar on 16/05/25.
//

import SwiftUI

//MARK: - Modifier
struct ViewStyle: ViewModifier {

    let topLeadingRadius: CGFloat
    let topTrailingRadius: CGFloat
    let bottomLeadingRadius: CGFloat
    let bottomTrailingRadius: CGFloat
    let radiusStyle: RoundedCornerStyle
    let borderColor: Color
    let borderWidth: CGFloat

    init(
        radius: CGFloat? = nil,
        topLeadingRadius: CGFloat = 0,
        topTrailingRadius: CGFloat = 0,
        bottomLeadingRadius: CGFloat = 0,
        bottomTrailingRadius: CGFloat = 0,
        radiusStyle: RoundedCornerStyle = .continuous,
        borderColor: Color = .clear,
        borderWidth: CGFloat = 0
    ) {
        self.topLeadingRadius = radius ?? topLeadingRadius
        self.topTrailingRadius = radius ?? topTrailingRadius
        self.bottomLeadingRadius = radius ?? bottomLeadingRadius
        self.bottomTrailingRadius = radius ?? bottomTrailingRadius
        self.radiusStyle = radiusStyle
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }

    func body(content: Content) -> some View {
        content
            .clipShape(
                .rect(
                    topLeadingRadius: topLeadingRadius,
                    bottomLeadingRadius: bottomLeadingRadius,
                    bottomTrailingRadius: bottomTrailingRadius,
                    topTrailingRadius: topTrailingRadius,
                    style: radiusStyle
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .path(
                        in: CGRect(
                            origin: .zero,
                            size: CGSize(width: 1, height: 1)
                        )
                    )
                    .stroke(borderColor, lineWidth: borderWidth)
                    .clipShape(
                        .rect(
                            topLeadingRadius: topLeadingRadius,
                            bottomLeadingRadius: bottomLeadingRadius,
                            bottomTrailingRadius: bottomTrailingRadius,
                            topTrailingRadius: topTrailingRadius,
                            style: radiusStyle
                        )
                    )
            )
    }

}
