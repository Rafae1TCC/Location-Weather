//
//  FailedView.swift
//  Location
//
//  Created by Rafael Cabrera on 8/27/26.
//
import SwiftUI
struct FailedView:View {
    let message:String
    let tryAgain: () -> Void
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 32))
                .foregroundStyle(.red)
            Text(message)
                .multilineTextAlignment(.center)
            Button("Try Again"){
                self.tryAgain()
            }.buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .cardStyle()
    }
}
#Preview {
    FailedView(message: "No location", tryAgain: {})
        .padding()
}
