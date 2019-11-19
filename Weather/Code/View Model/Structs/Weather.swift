//
//  Weather.swift
//  Weather
//
//  Created by Toto on 30/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import Foundation

struct Weather: WeatherProtocol {
    
    //MARK: Properties
    var date: String
    var temperature: Double?
    var humidity: Double?
    var rain: Double?
    var pressure: Double?
    var wind : Double?
    
    
    //MARK: Init
    init(date: String, temperature: Double, humidity: Double, rain: Double, pressure: Double, wind: Double) {
        self.date = date
        self.temperature = temperature
        self.humidity = humidity
        self.rain = rain
        self.pressure = pressure
        self.wind = wind
    }
}


