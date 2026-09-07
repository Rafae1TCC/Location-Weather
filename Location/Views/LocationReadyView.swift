//
//  LocationReadyView.swift
//  Location
//
//  Created by Rafael Cabrera on 8/27/26.
//
import SwiftUI

struct LocationReadyView:View {
    let latText:String
    let lonText:String
    let onRefresh: () -> Void
    let onSave: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Image(systemName: "location.fill")
                    .foregroundStyle(.blue)
                Text("Current Location")
                    .font(.headline)
                Spacer()
            }

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Latitude").font(.caption).foregroundStyle(.secondary)
                    Text(latText).font(.title3.monospacedDigit())
                }
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    Text("Longitude").font(.caption).foregroundStyle(.secondary)
                    Text(lonText).font(.title3.monospacedDigit())
                }
                Spacer()
            }

            HStack(spacing: 12) {
                Button(action: onRefresh) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                Button(action: onSave) {
                    Label("Save", systemImage: "checkmark.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .cardStyle()
    }
}

#Preview {
    LocationReadyView(latText: "123.333", lonText: "98.888", onRefresh: {}, onSave: {})
        .padding()
}
