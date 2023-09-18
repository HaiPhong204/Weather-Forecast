//
//  MapViewController.swift
//  WeatherForecast
//
//  Created by Windy on 12/09/2023.
//

import UIKit
import Reachability
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeView: UITextField!
    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherInfomationView: UIView!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    var isInternetAvailable = true
    let reachability = try! Reachability()
    var mapViewModel = MapViewModel()
    var weatherLocation : WeatherLocationModel? = nil
    var currentAnnotation: MKPointAnnotation?
    
    private let _weatherLocationRepository = WeatherLocationRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapSearchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        let tapweatherInfomationView = UITapGestureRecognizer(target: self, action: #selector(weatherInforTapped))
        spinnerView.startAnimating()
        checkMonitoringReachability()
        view.addGestureRecognizer(tapSearchGestureRecognizer)
        weatherInfomationView.addGestureRecognizer(tapweatherInfomationView)
    }
    
    @objc func handleTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        placeView.resignFirstResponder()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        if ((self.placeView.text?.isEmpty) == true) {
            let alertController = UIAlertController(title: "Location not found!", message: "Please enter location again!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        } else {
            Task {
                spinnerView.isHidden = false
                spinnerView.startAnimating()
                self.weatherLocation = await self.mapViewModel.getWeatherData(city: placeView.text!)
                spinnerView.stopAnimating()
                spinnerView.isHidden = true
                if(self.weatherLocation == nil) {
                    let alertController = UIAlertController(title: "Location not found!", message: "Please enter location again!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                _weatherLocationRepository.deleteAllData()
                _weatherLocationRepository.create(record: self.weatherLocation!)
                self.setupData(place: self.weatherLocation!.name)
            }
        }
    }
    
    func checkMonitoringReachability() {

        reachability.whenReachable = { [self] reachability in
            self.isInternetAvailable = true
            if reachability.connection == .wifi {
                Task {
                    self.weatherLocation = await self.mapViewModel.getWeatherData(city: "hanoi")
                    _weatherLocationRepository.deleteAllData()
                    _weatherLocationRepository.create(record: self.weatherLocation!)
                    spinnerView.stopAnimating()
                    spinnerView.isHidden = true
                    self.setupData(place: self.weatherLocation!.name)
                }
            } else if reachability.connection == .cellular {
                Task {
                    self.weatherLocation = await self.mapViewModel.getWeatherData(city: "hanoi")
                    _weatherLocationRepository.deleteAllData()
                    _weatherLocationRepository.create(record: self.weatherLocation!)
                    spinnerView.stopAnimating()
                    spinnerView.isHidden = true
                    self.setupData(place: self.weatherLocation!.name)
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

    func centerMapOnLocation(location: CLLocation, radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setupOldData() {
        self.weatherLocation = _weatherLocationRepository.getWeatherLocation()
        spinnerView.stopAnimating()
        spinnerView.isHidden = true
        setupData(place: self.weatherLocation!.name)
    }
    
    func setupData(place: String) {
        if weatherLocation == nil { return }
        DispatchQueue.main.async {
            
            if let annotation = self.currentAnnotation {
                self.mapView.removeAnnotation(annotation)
            }
            
            // Set location
            let initialLocation = CLLocation(latitude: self.weatherLocation!.coord.lat, longitude: self.weatherLocation!.coord.lon)
            let regionRadius: CLLocationDistance = 25000
            self.centerMapOnLocation(location: initialLocation, radius: regionRadius)
            
            // Add marker
            let annotation = MKPointAnnotation()
            annotation.coordinate = initialLocation.coordinate
            annotation.title = place
            self.mapView.addAnnotation(annotation)
            
            self.currentAnnotation = annotation
            
            // Load image from URL
            Task {
                let image = await self.mapViewModel.getIconImage(icon: self.weatherLocation!.weather.first!.icon)
                self.imageView.image = image
            }
            // Load currentday
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.dateView.text = "\(self.weatherLocation!.name), \(self.weatherLocation!.sys.country) " + dateFormatter.string(from: Date())
            // Load weather data
            self.overviewLabel.text = self.weatherLocation?.weather[0].description
            let tp_max = "H: \(self.weatherLocation?.main.temp_max ?? 0)"
            let tp_min = "L: \(self.weatherLocation?.main.temp_min ?? 0)"
            self.temperatureLabel.text = tp_max + " " + tp_min
            self.cloudLabel.text = "☁️ \(self.weatherLocation?.clouds.all ?? 0)%"
            self.humidityLabel.text = "Humidity: \(self.weatherLocation?.main.humidity ?? 0)%"
        }
    }
    
    @objc func weatherInforTapped() {
        self.performSegue(withIdentifier: "pushWeatherDetailScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushWeatherDetailScreen" {
            if let destinationVC = segue.destination as? DetailWeatherController {
                // Pass the locationName to the DetailWeatherViewController
                destinationVC.location = self.weatherLocation!.name
            }
        }
    }
    
}
