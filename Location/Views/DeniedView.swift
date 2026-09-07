//
//  DeniedView.swift
//  Location
//
//  Created by Rafael Cabrera on 9/3/26.
//

//
//  DeniedView.swift
//  Location
//

import SwiftUI
import UIKit

struct DeniedView: View {
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "location.slash.fill")
                .font(.system(size: 32))
                .foregroundStyle(.red)
            Text("Location Access Off")
                .bold()
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }.buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .cardStyle()
    }
}

#Preview {
    DeniedView(message: "Location access off, enable it in Settings")
        .padding()
}
