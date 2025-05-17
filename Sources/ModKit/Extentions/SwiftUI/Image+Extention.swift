//
//  Image+Extention.swift
//  ModKit
//
//  Created by Siva Sankar on 16/05/25.
//

import SwiftUI

extension Image {

    public init(sfSymbol sfsymbol: SFSymbolName) {
        self.init(sfSymbol: sfsymbol.rawValue)
    }

    public init(sfSymbol sfsymbolName: String) {
        self.init(systemName: sfsymbolName)
    }

    /// Make an image resizable and scale to fit
    public func responsiveImage(contentMode: ContentMode = .fit) -> some View {
        self.resizable()
            .aspectRatio(contentMode: contentMode)
    }

    /// Create a circular avatar image with border
    func circularAvatar(
        diameter: CGFloat,
        borderColor: Color = .white,
        borderWidth: CGFloat = 2
    ) -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: diameter, height: diameter)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
    
}
