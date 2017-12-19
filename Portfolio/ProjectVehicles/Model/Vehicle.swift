//
//  Vehicle.swift
//  Activity2
//
//  Created by MacStudent on 2017-10-27.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class Vehicle {
    public private(set) var name: String
    public private(set) var price: Double
    public private(set) var image: UIImage?
    
    init(_ name: String, _ price: Double, _ image: UIImage?) {
        self.name = name
        self.price = price
        self.image = image
    }
    
    public func setName(_ name: String) {
        self.name = name
    }
    public func setPrice(_ price: Double) {
        self.price = price
    }
    public func setImage(_ image: UIImage) {
        self.image = image
    }
}
