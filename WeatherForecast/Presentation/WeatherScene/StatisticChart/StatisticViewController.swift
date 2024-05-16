//
//  CelsiusViewController.swift
//  WeatherForecast
//
//  Created by Windy on 12/09/2023.
//

import UIKit

class StatisticViewController: UIViewController, CustomSegmentedControlDelegate {
    
    @IBOutlet weak var containerView: UIView!
    
    var currentViewController: UIViewController?
    var forecast : ForecastModel?
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Temperature", "Humidity", "Clouds", "Wind"])
            interfaceSegmented.selectorViewColor = UIColor(red: 28/255.0, green: 185/255.0, blue: 134/255.0, alpha: 1.0)
            interfaceSegmented.selectorTextColor = UIColor(red: 28/255.0, green: 185/255.0, blue: 134/255.0, alpha: 1.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interfaceSegmented.delegate = self
        showViewController(withIdentifier: "temperatureVC")
    }
    
    func showViewController(withIdentifier identifier: String) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: identifier) else {
            return
        }
        
        // Pass data to new viewcontroller
        if let temperatureViewController = viewController as? TemperatureViewController {
            temperatureViewController.weatherInfomation = self.forecast?.list
        } else if let humidityViewController = viewController as? HumidityViewController {
            humidityViewController.weatherInfomation = self.forecast?.list
        } else if let cloudsViewController = viewController as? CloudsViewController {
            cloudsViewController.weatherInfomation = self.forecast?.list
        } else if let windViewController = viewController as? WindViewController {
            windViewController.weatherInfomation = self.forecast?.list
        }
        
        // Remove the currently displayed view controller
        currentViewController?.removeFromParent()
        currentViewController?.view.removeFromSuperview()
        
        // Add the new view controller
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
        
        // Update the current view controller
        currentViewController = viewController
    }
    
    func change(to index: Int) {
        switch index {
        case 0:
            showViewController(withIdentifier: "temperatureVC")
        case 1:
            showViewController(withIdentifier: "humidityVC")
        case 2:
            showViewController(withIdentifier: "cloudsVC")
        case 3:
            showViewController(withIdentifier: "windVC")
        default:
            break
        }
    }
}
