//
//  DBWeather.swift
//  Weather
//
//  Created by Toto on 31/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import Foundation
import CoreData

extension DBWeather: WeatherProtocol {
    var date: String { return self.a_date ?? ""}
    var temperature: Double? { return self.a_temperature?.doubleValue }
    var humidity: Double? { return self.a_humidity?.doubleValue }
    var rain: Double? { return self.a_rain?.doubleValue }
    var pressure: Double? { return self.a_pressure?.doubleValue }
    var wind: Double? { return self.a_wind?.doubleValue }
}

extension DBWeather {
    static func create(weather: WeatherProtocol, in context: NSManagedObjectContext) {
        let dbWeather = DBWeather.mr_createEntity(in: context)
        
        dbWeather?.a_date = weather.date
        
        if let temperature = weather.temperature {
            dbWeather?.a_temperature = NSDecimalNumber(decimal: Decimal(floatLiteral: temperature))
        } else {
            dbWeather?.a_temperature = nil
        }
        
        if let humidity = weather.humidity {
            dbWeather?.a_humidity = NSDecimalNumber(decimal: Decimal(floatLiteral: humidity))
        } else {
            dbWeather?.a_humidity = nil
        }
        
        if let rain = weather.rain {
            dbWeather?.a_rain = NSDecimalNumber(decimal: Decimal(floatLiteral: rain))
        } else {
            dbWeather?.a_rain = nil
        }
        
        if let pressure = weather.pressure {
            dbWeather?.a_pressure = NSDecimalNumber(decimal: Decimal(floatLiteral: pressure))
        } else {
            dbWeather?.a_pressure = nil
        }
        
        if let wind = weather.wind {
            dbWeather?.a_wind = NSDecimalNumber(decimal: Decimal(floatLiteral: wind))
        } else {
            dbWeather?.a_wind = nil
        }
    }
}
