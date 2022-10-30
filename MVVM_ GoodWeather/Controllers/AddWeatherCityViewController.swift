//
//  AddWeatherCityViewController.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 29.10.2022.
//

import Foundation
import UIKit

class AddWeatherCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBAction func saveCityButtonPressed() {
        
        print("save")
        
        if let city = cityNameTextField.text {
            
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constants.key)&units=imperial")!
            
            let weatherResource = Resource<Any>(url: weatherURL) { data in
                
                return data
            }
            
            WebService().load(resource: weatherResource) { result in
                
            }
            
        }
        
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
