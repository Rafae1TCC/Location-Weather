//
//  WeatherModel.swift
//  Location
//
//  Created by Rafael Cabrera on 9/3/26.
//


import Foundation

struct OpenMeteoResponse: Decodable {
    let current_weather: CurrentWeatherData
}

struct CurrentWeatherData: Decodable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
    let time: String
}

struct WeatherModel {
    let temperature: Double   // Celsius
    let windSpeed: Double     // km/h
    let condition: String     // human-readable summary

    init(from data: CurrentWeatherData) {
        self.temperature = data.temperature
        self.windSpeed = data.windspeed
        self.condition = WeatherModel.conditionText(for: data.weathercode)
    }

    static func conditionText(for code: Int) -> String {
        switch code {
        case 0: return "Clear sky"
        case 1, 2, 3: return "Partly cloudy"
        case 45, 48: return "Fog"
        case 51, 53, 55: return "Drizzle"
        case 61, 63, 65: return "Rain"
        case 71, 73, 75: return "Snow"
        case 80, 81, 82: return "Rain showers"
        case 95: return "Thunderstorm"
        default: return "Unknown"
        }
    }
}
