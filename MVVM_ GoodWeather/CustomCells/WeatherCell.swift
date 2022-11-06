//
//  WeatherCell.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 29.10.2022.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell  {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ vm: WeatherViewModel) {
        
        self.cityNameLabel.text = vm.name.value
        self .temperatureLabel.text = "\(vm.currentTemperature.temperature.value.formatAsDegree)"
    }
}
