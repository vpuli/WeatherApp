//
//  WeatherDataSource.swift
//  WeatherExample
//
//  Created by Vineeth Puli on 12/27/18.
//  Copyright © 2018 RUMAD. All rights reserved.
//

import Foundation

struct Weather : Codable {
    let latitude : Double
    let longitude : Double
    let timezone : String
    let currently : CurrentWeather
    let daily : Daily
}

struct CurrentWeather : Codable {
    let icon : String
    let summary : String
    let temperature : Double
}

struct Daily : Codable {
    let data : [DailyData]
}

struct DailyData : Codable {
    let time : Int
    let summary : String
    let icon : String
    let temperatureHigh : Double
    let temperatureLow : Double
}

struct WeatherDataSource {
    
    let urlString = "https://api.darksky.net/forecast/dc976eadf35fd6d6377cb28111e0a835/40.7128,-74.0060"
    
    func getWeather(completion: @escaping (Weather)->())  {
        guard let url = URL(string: urlString) else { return }
        
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                let decoder = JSONDecoder()
                do {
                    let parsed = try decoder.decode(Weather.self, from: jsonData)
                    completion(parsed)
                } catch {
                    print(error)
                }
            } else {
                print("something went wrong")
            }
            
        }
        task.resume()
    }
    
    
}
