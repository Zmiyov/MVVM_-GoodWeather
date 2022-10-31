//
//  Double+Extensions.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 31.10.2022.
//

import Foundation

extension Double {
    
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
}
