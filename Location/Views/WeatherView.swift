//
//  WeatherView.swift
//  Location
//
//  Created by Rafael Cabrera on 9/3/26.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Image(systemName: "cloud.sun.fill")
                    .foregroundStyle(.orange)
                Text("Weather")
                    .font(.headline)
                Spacer()
            }

            if weatherViewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView("Loading weather...")
                    Spacer()
                }
                .padding(.vertical, 8)
            } else if let errorMessage = weatherViewModel.errorMessage {
                VStack(spacing: 10) {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    Button("Retry") {
                        weatherViewModel.refresh()
                    }
                    .buttonStyle(.bordered)
                }
            } else if let weather = weatherViewModel.weather {
                HStack(spacing: 20) {
                    WeatherStat(icon: "thermometer", label: "Temp", value: String(format: "%.1f°C", weather.temperature))
                    WeatherStat(icon: "wind", label: "Wind", value: String(format: "%.1f km/h", weather.windSpeed))
                }
                HStack {
                    Label(weather.condition, systemImage: "sun.max.fill")
                        .font(.subheadline)
                    Spacer()
                    if let lastUpdated = weatherViewModel.lastUpdated {
                        Text("Updated \(lastUpdated, style: .time)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Button(action: { weatherViewModel.refresh() }) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else {
                Text("No weather data yet")
                    .foregroundStyle(.secondary)
            }
        }
        .cardStyle()
    }
}

private struct WeatherStat: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Label(label, systemImage: icon)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title3.monospacedDigit())
        }
    }
}

#Preview {
    WeatherView(weatherViewModel: WeatherViewModel())
        .padding()
}
