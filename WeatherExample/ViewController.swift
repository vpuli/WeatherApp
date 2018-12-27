//
//  ViewController.swift
//  WeatherExample
//
//  Created by Vineeth Puli on 12/27/18.
//  Copyright © 2018 RUMAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherSummary: UILabel!
    
    let api = WeatherDataSource()
    var weeklyForecast : Daily?
    
    let weatherIconDict : [String : UIImage] = [
        "clear-day": #imageLiteral(resourceName: "32.png"),
        "clear-night": #imageLiteral(resourceName: "31.png"),
        "rain": #imageLiteral(resourceName: "11.png"),
        "snow": #imageLiteral(resourceName: "42.png"),
        "sleet": #imageLiteral(resourceName: "10.png"),
        "wind": #imageLiteral(resourceName: "24.png"),
        "fog": #imageLiteral(resourceName: "20.png"),
        "cloudy": #imageLiteral(resourceName: "26.png"),
        "partly-cloudy-day": #imageLiteral(resourceName: "30.png"),
        "partly-cloudy-night": #imageLiteral(resourceName: "27.png")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getWeather { (weather) in
            print(weather)
            print(weather.daily)

            DispatchQueue.main.async {
                print("Updating UI")
                    self.currentTempLabel.text = "\(weather.currently.temperature)°"
                self.currentWeatherSummary.text = weather.currently.summary
                print("ICON: \(weather.currently.icon)")
                self.currentWeatherImage.image = self.weatherIconDict[weather.currently.icon]
                self.weeklyForecast = weather.daily
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showForecastSegue" {
            guard let forecastViewController = segue.destination as? ForecastViewController else {
                return
            }
            forecastViewController.weeklyForecast = self.weeklyForecast
        }
    }
}

