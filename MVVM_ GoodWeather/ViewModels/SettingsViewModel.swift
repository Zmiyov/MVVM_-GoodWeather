//
//  SettingsViewModel.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 03.11.2022.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
    
    var displayName: String {
        get {
            switch self {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}

struct SettingsViewModel {
    
    let units = Unit.allCases
    
}
