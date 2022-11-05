//
//  WeatherListViewModel.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 31.10.2022.
//

import Foundation

struct WeatherListViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
    
    mutating func addWeatherViewModel(_ viewModel: WeatherViewModel ) {
        self.weatherViewModels.append(viewModel)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return self.weatherViewModels[index]
    }
    
    private mutating func toCelsius() {
        
        weatherViewModels = weatherViewModels.map { viewModel in
            var weatherModel = viewModel
            weatherModel.currentTemperature.temperature = (weatherModel.currentTemperature.temperature - 32) * 5/9
            return weatherModel
        }
    }
    
    private mutating func toFahrenheit() {
        
        weatherViewModels = weatherViewModels.map { viewModel in
            var weatherModel = viewModel
            weatherModel.currentTemperature.temperature = (weatherModel.currentTemperature.temperature * 9/5) + 32
            return weatherModel
        }
    }
    
    mutating func updateUnit(to unit: Unit) {
        switch unit {
        case .fahrenheit:
            toFahrenheit()
        case .celsius:
            toCelsius()
        }
    }
}

struct WeatherViewModel: Decodable {
    
    let name: String
    var currentTemperature: TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
}

struct TemperatureViewModel: Decodable {
    
    var temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
