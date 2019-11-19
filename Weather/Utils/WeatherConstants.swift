//
//  WeatherConstants.swift
//  Weather
//
//  Created by Toto on 31/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import Foundation

struct WeatherConstants {
    //MARK: Network constants
    static let badRequest: Int = 400
    static let model_run: String    = "model_run"
    static let message: String = "message"
    static let request_state: String = "request_state"
    static let request_key: String = "request_key"

    //MARK: Json properties
    static let temperature: String = "temperature"
    static let temperatureValue: String = "2m"
    static let pressure: String = "pression"
    static let pressureValue: String = "niveau_de_la_mer"
    static let humidity: String = "humidite"
    static let humidityValue: String = "2m"
    static let rain: String = "pluie"
    static let wind: String = "vent_moyen"
    static let windValue: String = "10m"
    
    //MARK: Cell constants
    static let dateFormatter: String = "yyyy-MM-dd HH:mm:ss"
}
