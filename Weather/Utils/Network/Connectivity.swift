//
//  Connectivity.swift
//  Weather
//
//  Created by Toto on 31/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    /* Return true if device is connected to network and false otherwise. */
    var isConnectedToNetwork: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
