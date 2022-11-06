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
        
        setupViewModelBindings()
        
    }
    
    private func setupViewModelBindings() {
        
        if let weatherVM = self.weatherViewModel {
            
            weatherVM.name.bind { self.cityNameLabel.text = $0 }
            weatherVM.currentTemperature.temperature.bind { self.currentTemperatureLabel.text = $0.formatAsDegree }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            self.weatherViewModel?.name.value = "Boston"
        }
    }
}
