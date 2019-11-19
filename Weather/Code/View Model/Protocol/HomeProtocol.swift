//
//  HomeProtocol.swift
//  Weather
//
//  Created by Toto on 31/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import Foundation

protocol WeatherProtocol {
    var date: String { get }
    var temperature: Double? { get }
    var humidity: Double? { get }
    var rain: Double? { get }
    var pressure: Double? { get }
    var wind : Double? { get }
}

extension WeatherProtocol {
    var formattedDate: Date {
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = WeatherConstants.dateFormatter
        
        guard let date = stringToDateFormatter.date(from: self.date) else { return Date() }
        return date
    }
}
