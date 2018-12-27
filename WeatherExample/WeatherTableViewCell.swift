//
//  WeatherTableViewCell.swift
//  WeatherExample
//
//  Created by Vineeth Puli on 12/27/18.
//  Copyright © 2018 RUMAD. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    func setUpCell(dateString : String, temperature: Double, weatherImage : UIImage?, weatherSummary : String) {
        self.dateLabel.text = dateString
        self.temperatureLabel.text = "\(temperature)°"
        if let weatherImage = weatherImage {
            self.weatherImageView.image = weatherImage
        }
        self.summaryLabel.text = weatherSummary
    }

}
