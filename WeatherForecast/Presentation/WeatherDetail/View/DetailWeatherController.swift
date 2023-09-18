//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Windy on 10/09/2023.
//

import UIKit
import CoreLocation
import Reachability

class DetailWeatherController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let _forecastRepository = ForecastRepository()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    var forecast : ForecastModel?
    var currentViewController: UIViewController?
    var location : String = ""
    var weatherDetailViewModel = WeatherDetailViewModel()
    var changeToFahrenheit = false
    let reachability = try! Reachability()
    var isInternetAvailable = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = "Weather forecast for \(location)"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        spinnerView.startAnimating()
        
        let cellNibForecast = UINib(nibName: "ForecastViewCell", bundle: nil)
        tableView.register(cellNibForecast, forCellReuseIdentifier: "ForecastViewCell")
        
        getData()
    }
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            changeToFahrenheit = false
        } else {
            changeToFahrenheit = true
        }
        tableView.reloadData()
    }
    
    @IBAction func statistic(_ sender: Any) {
        self.performSegue(withIdentifier: "pushStatisticScreen", sender: self)
    }
    
    func getData() {
        reachability.whenReachable = { [self] reachability in
            self.isInternetAvailable = true
            if reachability.connection == .wifi {
                Task {
                    let data = await self.weatherDetailViewModel.getForecastData(city: location)
                    spinnerView.stopAnimating()
                    spinnerView.isHidden = true
                    if(data == nil) {
                        return
                    } else {
                        self.forecast = data
                        self.tableView.reloadData()
                        _forecastRepository.deleteAll()
                        _forecastRepository.create(record: data!)
                    }
                }
            } else if reachability.connection == .cellular {
                Task {
                    let data = await self.weatherDetailViewModel.getForecastData(city: location)
                    spinnerView.stopAnimating()
                    spinnerView.isHidden = true
                    if(data == nil) {
                        return
                    } else {
                        self.forecast = data
                        self.tableView.reloadData()
                        _forecastRepository.deleteAll()
                        _forecastRepository.create(record: data!)
                    }
                }
            }
        }
        
        reachability.whenUnreachable = { _ in
            self.isInternetAvailable = false
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "NOT CONNECTED", message: "Please connect to the internet. Do you want to continue using the app with the old data?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.setupOldData()
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func setupOldData() {
        self.forecast = _forecastRepository.getForecast()
        spinnerView.stopAnimating()
        spinnerView.isHidden = true
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastViewCell", for: indexPath) as! ForecastViewCell
        // Make sure the weatherForecast and list are not nil
        guard let weatherForecastList = self.forecast,
              let forecastData = weatherForecastList.list[indexPath.row] as WeatherInformationModel? else {
            return cell
        }
        
        cell.dateLabel.text = forecastData.dt_txt
        let temperatureInt = Int(forecastData.main.temp)
        cell.temperatureLabel.text = "\(temperatureInt)℃"
        
        // Load image from URL
        Task {
            let image = await self.weatherDetailViewModel.getIconImage(icon: forecastData.weather.first!.icon)
            cell.imageLabel.image = image
        }
        // Load currentday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        cell.dateLabel.text = forecastData.dt_txt
        // Load forecast data
        cell.overViewLabel.text = forecastData.weather.first?.description
        if(changeToFahrenheit == false) {
            let tp_max = "H: \(forecastData.main.temp_max)°C"
            let tp_min = "L: \(forecastData.main.temp_min)°C"
            cell.temperatureLabel.text = tp_max + " " + tp_min
        } else {
            let tp_max = String(format: "H: %.2f°F", forecastData.main.temp_max * 9/5 + 32)
            let tp_min = String(format: "L: %.2f°F", forecastData.main.temp_min * 9/5 + 32)
            cell.temperatureLabel.text = tp_max + " " + tp_min
        }
        cell.cloudLabel.text = "☁️ \(forecastData.clouds.all)%"
        cell.humidityLabel.text = "Humidity: \(forecastData.main.humidity)%"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushStatisticScreen" {
            if let destinationVC = segue.destination as? StatisticViewController {
                // Pass the locationName to the DetailWeatherViewController
                destinationVC.forecast = forecast
            }
        }
    }
}
