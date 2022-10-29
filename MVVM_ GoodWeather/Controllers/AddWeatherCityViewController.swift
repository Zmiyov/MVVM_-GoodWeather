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
        
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
