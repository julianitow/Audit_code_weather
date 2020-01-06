//
//  HomeCell.swift
//  Weather
//
//  Created by Toto on 30/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Configure Cell
    func configurewith(_ weather: WeatherProtocol, at index: Int) {
        self.backgroundColor = WeatherUtils.weatherColor(index: index)
        self.selectImage(weather)
        self.dateLabel.text = WeatherUtils.changeDateFormat(dateString: weather.date) 
        self.temperatureLabel.text = String(format: "%.0f", weather.temperature! - 273.15) + "°C"
        //self.weatherImageView
    }
    
    func selectImage(_ weather: WeatherProtocol) {
        
        guard let humidity = weather.humidity else {
            return
        }
        
        guard let wind = weather.wind else {
            return
        }
        
        guard let rain = weather.rain else {
            return
        }
        
        if (rain >= 0.3 && wind < 21.0) {
            self.weatherImageView.image = UIImage(named: "rain_sky")
        }
        
        if (rain < 0.3 && humidity >= 60.0) {
            self.weatherImageView.image = UIImage(named: "foggy_sky")
        }
        
        if (rain >= 0.3 && wind > 21.0) {
            self.weatherImageView.image = UIImage(named: "wind_sky")
        }
        
        if (wind < 21.0 && rain < 0.3) {
            self.weatherImageView.image = UIImage(named: "clear_sky")
        }
        
        if (wind > 21.0 && rain > 0.3) {
            self.weatherImageView.image = UIImage(named: "wind_rain_sky")
        }
    }
}
