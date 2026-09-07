//
//  PermissionView.swift
//  Location
//
//  Created by Rafael Cabrera on 8/27/26.
//
import SwiftUI
struct PermissionView:View {
    let onEnable: () -> Void
    var body: some View {
        VStack(spacing: 12){
            Image(systemName: "location.circle")
                .font(.system(size: 40))
                .foregroundStyle(.blue)
            Text("We need your permission to save check-ins")
                .bold()
                .multilineTextAlignment(.center)
            Button("Enable Location"){
                self.onEnable()
            }.buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .cardStyle()
    }
}
#Preview {
    PermissionView(onEnable: {})
        .padding()
}
