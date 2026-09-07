//
//  LoadingView.swift
//  Location
//
//  Created by Rafael Cabrera on 8/27/26.
//


import SwiftUI
struct LoadingView:View {
    var body: some View {
        VStack(spacing: 12) {
            ProgressView().tint(.blue)
            Text("Loading location...")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .cardStyle()
    }
}
#Preview {
    LoadingView()
        .padding()
}
