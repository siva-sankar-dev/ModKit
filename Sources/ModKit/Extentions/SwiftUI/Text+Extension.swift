//
//  Text+Extension.swift
//  ModKit
//
//  Created by Siva Sankar on 16/05/25.
//

import SwiftUI

extension Text {

    public func align(_ alignment: TextAlignment) -> some View {
        multilineTextAlignment(alignment)
    }
}
