//
//  AddWeatherCityViewController.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 29.10.2022.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(viewModel: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    
    private var addCityViewModel = AddCityViewModel()
    
    @IBOutlet weak var cityNameTextField: BindingTextField! {
        didSet {
            cityNameTextField.bind { self.addCityViewModel.city = $0 }
        }
    }
    @IBOutlet weak var stateTextField: BindingTextField! {
        didSet {
            stateTextField.bind { self.addCityViewModel.state = $0 }
        }
    }
    @IBOutlet weak var zipCodeTextField: BindingTextField! {
        didSet {
            zipCodeTextField.bind { self.addCityViewModel.zipCode = $0 }
        }
    }
    
    var delegate: AddWeatherDelegate?
    
    @IBAction func saveCityButtonPressed() {
        
        print(self.addCityViewModel)
        
        if let city = cityNameTextField.text {
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constants.key)&units=imperial")!
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                let weatherViewModel = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherViewModel
            }
            
            WebService().load(resource: weatherResource) { [weak self] result in
                if let weatherVM = result {
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(viewModel: weatherVM)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
