//
//  Cars.swift
//  Activity2
//
//  Created by Araceli Teixeira on 25/10/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

enum Rating: Int {
    case Excellent, Good, Average, Bad
}

class Car: Vehicle {
    public private(set) var isElectric: Bool
    public private(set) var capacity: Int
    public private(set) var rating: Rating
    
    init(_ name: String, _ price: Double, _ image: UIImage?, _ isElectric: Bool, _ capacity: Int, _ rating: Rating) {
        self.isElectric = isElectric
        self.capacity = capacity
        self.rating = rating
        super.init(name, price, image)
    }
    
    public func setIsElectric(_ isElectric: Bool) {
        self.isElectric = isElectric
    }
    public func setCapacity(_ capacity: Int) {
        self.capacity = capacity
    }
    public func setRating(_ rating: Rating) {
        self.rating = rating
    }
}
