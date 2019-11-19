//
//  WeatherUtils.swift
//  Weather
//
//  Created by Toto on 30/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import UIKit

struct WeatherUtils {
    
    struct Colors {
        static let watermelon: UInt = 0xFF5670
        static let yellow: UInt = 0xFFCE00
        static let darkMagenta: UInt = 0xA90097
        static let greenBlue: UInt = 0x08A4A9
    }
    
    static func weatherColor(index pIndex:Int) -> UIColor {
        let arrayColor = [
            UIColor(hexString: Colors.watermelon),
            UIColor(hexString: Colors.yellow),
            UIColor(hexString: Colors.darkMagenta),
            UIColor(hexString: Colors.greenBlue),
        ]
        return arrayColor[(pIndex % arrayColor.count)]
    }
    
    /* It would be necessary to convert the date obtained in format string of the service in Date format while inserting the format of date wanted.
     Then convert the type of date to String while inserting another style. */
    static func changeDateFormat(dateString: String) -> String? {
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = WeatherConstants.dateFormatter
        
        guard let date = stringToDateFormatter.date(from: dateString) else { return nil }
        
        let dateToStringFormatter = DateFormatter()
        dateToStringFormatter.locale = Locale(identifier: "fr_FR")
        dateToStringFormatter.dateStyle = .short
        dateToStringFormatter.timeStyle = .short
        
        return dateToStringFormatter.string(from: date)
    }
}
