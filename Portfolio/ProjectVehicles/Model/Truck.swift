//
//  Truck.swift
//  Activity2
//
//  Created by Araceli Teixeira on 25/10/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class Truck: Vehicle {
    public private(set) var size: Double
    public private(set) var volume: Double
    
    init(_ name: String, _ price: Double, _ image: UIImage?, _ size: Double, _ volume: Double) {
        self.size = size
        self.volume = volume
        super.init(name, price, image)
    }
    
    public func setSize(_ size: Double) {
        self.size = size
    }
    public func setVolume(_ volume: Double) {
        self.volume = volume
    }
}
