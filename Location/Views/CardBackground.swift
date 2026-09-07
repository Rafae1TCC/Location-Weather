//
//  CardBackground.swift
//  Location
//
//  Created by Rafael Cabrera on 9/3/26.
//


//
//  CardBackground.swift
//  Location
//

import SwiftUI

struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardBackground())
    }
}