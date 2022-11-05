//
//  WeatherListTableViewController.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 29.10.2022.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate  {

    
    private var weatherListViewModel = WeatherListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - AddWeatherDelegate
    
    func addWeatherDidSave(viewModel: WeatherViewModel) {
        
        self.weatherListViewModel.addWeatherViewModel(viewModel)
        self.tableView.reloadData()
    }
    
    //MARK: - Table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListViewModel.numberOfRows(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        
        let weatherVM = self.weatherListViewModel.modelAt(indexPath.row)
        
        cell.configure(weatherVM)
        
        return cell
    }
    
    //MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddWeatherCityViewController" {
            
            prepareSegueForAddWeatherCityViewController(segue: segue)
        } else if segue.identifier == "SettingsTableViewController" {
            
            prepareSegueForSettingsTableViewController(segue: segue)
        } else if segue.identifier == "WeatherDetailsViewController" {
            
            prepareSegueForWeatherDetailsViewController(segue: segue)
        }
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("Navigation controller not found")
        }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("AddWeatherCityViewController not found")
        }
        addWeatherCityVC.delegate = self
    }
    
    private func prepareSegueForSettingsTableViewController(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("Navigation controller not found")
        }
        
        guard let settingsTableVC = nav.viewControllers.first as? SettingsTableViewController else {
            fatalError("SettingsTableViewController not found")
        }
        settingsTableVC.delegate = self
    }
    
    private func prepareSegueForWeatherDetailsViewController(segue: UIStoryboardSegue) {
        
        guard let weatherDetailsVC = segue.destination as? WeatherDetailsViewController, let indexPath = self.tableView.indexPathForSelectedRow else { return }
         
        let weatherVM = self.weatherListViewModel.modelAt(indexPath.row)
        weatherDetailsVC.weatherViewModel = weatherVM
    }
}

extension WeatherListTableViewController: SettingsDelegate {
    
    func settingsDone(viewModel: SettingsViewModel) {
        
        self.weatherListViewModel.updateUnit(to: viewModel.selectedUnit)
        self.tableView.reloadData()
    }
}
