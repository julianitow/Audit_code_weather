//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Toto on 30/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import Foundation
import Alamofire
import MagicalRecord
import CoreLocation

class WeatherViewModel{
    
    //MARK: Properties
    typealias ServiceResponse = (Error?) -> Void
    var weathers: [WeatherProtocol] {
        let dbWeathers = (DBWeather.mr_findAll() as? [WeatherProtocol]) ?? []
        return  dbWeathers.sorted(by: { $0.formattedDate.compare($1.formattedDate) == .orderedAscending })
    }

    /*
     Execute the request on the webservice with the data provided in the parameters.
     - If successful, if the return code is different from 400 or if it is between 200
     and 300 it means that we got a good response from the server. In this case we will send
     in the completion the array of weather contained in response Json. In the opposite case, we will send
     in the completion a nil array and a nil error.
     - In case of failure, we will send in the completion a nil array and an error.
     */
    func fetchWeather(currentLocation: CLLocation?, completion: @escaping ServiceResponse) {
        
        let preferences = UserDefaults.standard
        
        let currentLevelKey = "VU8EE1IsBCZUeVFmBHIGLwVtVWAOeAYhAn4HZAtuVShROgBhUjJcOgdpUy5QfwcxBSgPbFxnADBTOFYuXy1TMlU%2FBGhSOQRjVDtRNAQrBi0FK1U0Di4GIQJnB2ILeFU0UTEAelI5XDoHdlMwUGEHNwUpD3BcYgA9UzZWNV82UzhVNwRkUjEEYVQkUSwEMQZmBTJVNQ4wBjkCZgc2C2ZVMFFnADVSOFw7B3ZTOFBhBzQFMg9vXGYAO1MwVi5fLVNJVUUEfVJxBCRUblF1BCkGZwVoVWE%3D&_c=88bf0afd6ef9730869e30eced820d420"
        
        let currentLevel = 1
            preferences.set(currentLevel, forKey: currentLevelKey)
        
        //  Save to disk
        let didSave = preferences.synchronize()
        
        if !didSave {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
        
        //TOKEN D'AUTHENTIFICATION A SEPARER DE l'URL POUR PLUS DE VISIBILITE
        let urlString = "https://www.infoclimat.fr/public-api/gfs/json?_ll=\(48.85341),\(2.3488)&_auth=VU8EE1IsBCZUeVFmBHIGLwVtVWAOeAYhAn4HZAtuVShROgBhUjJcOgdpUy5QfwcxBSgPbFxnADBTOFYuXy1TMlU%2FBGhSOQRjVDtRNAQrBi0FK1U0Di4GIQJnB2ILeFU0UTEAelI5XDoHdlMwUGEHNwUpD3BcYgA9UzZWNV82UzhVNwRkUjEEYVQkUSwEMQZmBTJVNQ4wBjkCZgc2C2ZVMFFnADVSOFw7B3ZTOFBhBzQFMg9vXGYAO1MwVi5fLVNJVUUEfVJxBCRUblF1BCkGZwVoVWE%3D&_c=88bf0afd6ef9730869e30eced820d420"
        guard let url = URL(string: urlString) else { return }
        
        Alamofire.request(url).validate().responseJSON { response in
            switch (response.result) {
            case .success(let success):
                guard let success = success as? [String : Any], let request_state = success[WeatherConstants.request_state] as? Int, request_state != WeatherConstants.badRequest else {
                    completion(nil)
                    return
                }
                
                if let jsonData = response.data {
                    if let jsonDictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        let jsonKeysArray = Array(jsonDictionary.keys)
                        var jsonKeys = jsonKeysArray.filter({ $0 != WeatherConstants.message})
                        jsonKeys = jsonKeys.filter({ $0 != WeatherConstants.model_run})
                        jsonKeys = jsonKeys.filter({ $0 != WeatherConstants.request_state})
                        jsonKeys = jsonKeys.filter({ $0 != WeatherConstants.request_key})
                        
                        var weathers: [WeatherProtocol] = []
                        
                        for jsonKey in 0..<jsonKeys.count - 1 {
                            if let date = jsonDictionary[jsonKeys[jsonKey]] as? [String: Any] {
                                let dateValue = jsonKeys[jsonKey]
                                let temperatureDictionary = date[WeatherConstants.temperature] as! [String: Any]
                                let temperature = temperatureDictionary[WeatherConstants.temperatureValue] as! Double
                                let pressureDictionary = date[WeatherConstants.pressure] as! [String: Any]
                                let pressure = pressureDictionary[WeatherConstants.pressureValue] as! Double
                                let humidityDictionary = date[WeatherConstants.humidity] as! [String: Any]
                                let humidity = humidityDictionary[WeatherConstants.humidityValue] as! Double
                                let rain = date[WeatherConstants.rain] as! Double
                                let windDictionary = date[WeatherConstants.wind] as! [String: Any]
                                let wind = windDictionary[WeatherConstants.windValue] as! Double
                                
                                let weather = Weather(date: dateValue, temperature: temperature, humidity: humidity, rain: rain, pressure: pressure, wind: wind)
                                weathers.append(weather)
                            }
                        }
                       
                        DispatchQueue.global(qos: .background).async {
                            MagicalRecord.save({ (context) in
                                DBWeather.mr_truncateAll(in: context)
                                weathers.forEach({ (weather) in
                                    DBWeather.create(weather: weather, in: context)
                                })
                            }, completion: { (_, error) in
                                DispatchQueue.main.async {
                                    completion(error)
                                }
                            })
                        }
                    }
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
}
