//
//  WeatherService.swift
//  Location
//
//  Created by Rafael Cabrera on 9/3/26.
//


//
//  WeatherService.swift
//  Location
//

import Foundation

enum WeatherServiceError: Error, LocalizedError {
    case invalidURL
    case badResponse
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Could not build the weather request."
        case .badResponse: return "Weather server returned an error."
        case .decodingFailed: return "Could not read the weather data."
        }
    }
}

struct WeatherService {
    private let baseURL = "https://api.open-meteo.com/v1/forecast"

    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherModel {
        // Build URL safely with URLComponents (no string-mashing)
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(name: "current_weather", value: "true")
        ]

        guard let url = components?.url else {
            throw WeatherServiceError.invalidURL
        }

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            // Covers no internet / timeout / other transport errors
            throw error
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw WeatherServiceError.badResponse
        }

        do {
            let decoded = try JSONDecoder().decode(OpenMeteoResponse.self, from: data)
            return WeatherModel(from: decoded.current_weather)
        } catch {
            throw WeatherServiceError.decodingFailed
        }
    }
}
