//
//  ListView.swift
//  Location
//
//  Created by Rafael Cabrera on 8/27/26.
//
import SwiftUI

struct ListView:View {
    let checkIns:[CheckInModel]
    let onClearAll: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Check-Ins")
                    .font(.headline)
                Spacer()
                if !checkIns.isEmpty {
                    Button("Clear all", role: .destructive) {
                        onClearAll()
                    }
                    .font(.subheadline)
                }
            }

            if checkIns.isEmpty {
                Text("No check-ins yet")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 20)
            } else {
                VStack(spacing: 10) {
                    ForEach(checkIns) { item in
                        CheckInRow(item: item)
                    }
                }
            }
        }
        .cardStyle()
    }
}

private struct CheckInRow: View {
    let item: CheckInModel

    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .foregroundStyle(.blue)
            VStack(alignment: .leading, spacing: 2) {
                Text("Lat \(String(format: "%.2f", item.latitude)), Lon \(String(format: "%.2f", item.longitude))")
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(item.timeStamp, style: .date)
                Text(item.timeStamp, style: .time)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    ListView(checkIns: [CheckInModel(latitude: 123.123, longitude: 321.321)], onClearAll: {})
        .padding()
}
