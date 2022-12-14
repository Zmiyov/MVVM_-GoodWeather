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
            let weatherModel = viewModel
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value - 32) * 5/9
            return weatherModel
        }
    }
    
    private mutating func toFahrenheit() {
        
        weatherViewModels = weatherViewModels.map { viewModel in
            let  weatherModel = viewModel
            weatherModel.currentTemperature.temperature.value  = (weatherModel.currentTemperature.temperature.value * 9/5) + 32
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

// Type Eraser

class Dynamic<T>: Decodable where T: Decodable {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
}

struct WeatherViewModel: Decodable {
    
    let name: Dynamic<String>
    var currentTemperature: TemperatureViewModel
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = Dynamic(try container.decode(String.self, forKey: .name))
        self.currentTemperature = try container.decode(TemperatureViewModel.self, forKey: .currentTemperature)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
}

struct TemperatureViewModel: Decodable {
    
    var temperature: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        self.temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
        self.temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
