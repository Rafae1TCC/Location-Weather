//
//  WeatherViewModel.swift
//  Location
//
//  Created by Rafael Cabrera on 9/3/26.
//


import Foundation
import CoreLocation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var weather: WeatherModel?
    @Published var errorMessage: String?
    @Published var lastUpdated: Date?

    private let service = WeatherService()
    private var lastCoordinate: CLLocationCoordinate2D?

    func fetchWeather(coordinate: CLLocationCoordinate2D) {
        lastCoordinate = coordinate
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let result = try await service.fetchWeather(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude
                )
                self.weather = result
                self.lastUpdated = Date()
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }

    // Used by the retry button and the manual refresh action
    func refresh() {
        guard let coordinate = lastCoordinate else { return }
        fetchWeather(coordinate: coordinate)
    }
}
