//
//  ForecastViewController.swift
//  WeatherExample
//
//  Created by Vineeth Puli on 12/27/18.
//  Copyright © 2018 RUMAD. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    var weeklyForecast : Daily?
    let dateFormatter = DateFormatter()
    
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
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weekly Forecast"
        tableView.delegate = self
        tableView.dataSource = self
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MM/dd"
    }

}

extension ForecastViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dailyData = weeklyForecast?.data else {
            return 0
        }
        return dailyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dailyData = weeklyForecast?.data else {
            return UITableViewCell()
        }
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        let weather = dailyData[indexPath.row]
        
        //code to get date for current weather cell
        let date = Date.init(timeIntervalSince1970: TimeInterval(weather.time))
        let dateString = dateFormatter.string(from: date)
        
        //set up UI for cell
        weatherCell.setUpCell(dateString: dateString, temperature: weather.temperatureHigh, weatherImage: self.weatherIconDict[weather.icon], weatherSummary: weather.summary)
        return weatherCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
}
