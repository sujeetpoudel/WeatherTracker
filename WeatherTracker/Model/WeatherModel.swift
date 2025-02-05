//
//  WeatherModel.swift
//  WeatherTracker
//
//  Created by Sujeet Poudel on 2/2/25.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
}

struct Location: Codable {
    let name: String
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let condition: WeatherCondition
    let humidity: Int
    let uv: Double
    let feelslike_c: Double
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
}
