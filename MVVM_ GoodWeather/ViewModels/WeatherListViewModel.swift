//
//  WeatherListViewModel.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 31.10.2022.
//

import Foundation

struct WeatherListViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
}

struct WeatherViewModel: Decodable {
    
    let name: String
    let currentTemperature: TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
}

struct TemperatureViewModel: Decodable {
    
    let temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
