//
//  WeatherDetailsViewController.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 05.11.2022.
//

import Foundation
import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let weatherVM = weatherViewModel {
            self.cityNameLabel.text = weatherVM.name
            self.currentTemperatureLabel.text = weatherVM.currentTemperature.temperature.formatAsDegree
        }

    }
    
}
