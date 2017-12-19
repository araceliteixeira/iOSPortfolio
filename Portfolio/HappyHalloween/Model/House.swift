//
//  House.swift
//  HappyHalloween
//
//  Created by Macstudent on 2017-11-01.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class House {
    public private(set) var address: String
    public private(set) var numberOfCandies: Int
    public private(set) var imgHouse: UIImage?
    public private(set) var imgRate: UIImage?
    
    init(_ address: String, _ numberOfCandies: Int, _ imgHouse: UIImage?) {
        self.address = address
        self.numberOfCandies = numberOfCandies
        self.imgHouse = imgHouse
        
        if numberOfCandies >= 5 {
            imgRate = UIImage(named: "happy")
        } else if numberOfCandies <= 1 {
            imgRate = UIImage(named: "sad")
        } else {
            imgRate = UIImage(named: "neutral")
        }
    }
    
    func setAddress(_ address: String) {
        self.address = address
    }
    
    func setNumberOfCandies(_ numberOfCandies: Int) {
        self.numberOfCandies = numberOfCandies
        if numberOfCandies >= 5 {
            imgRate = UIImage(named: "happy")
        } else if numberOfCandies <= 1 {
            imgRate = UIImage(named: "sad")
        } else {
            imgRate = UIImage(named: "neutral")
        }
    }
    
    func setImgHouse(_ imgHouse: UIImage?) {
        self.imgHouse = imgHouse
    }
    
    func setImgRate(_ imgRate: UIImage?) {
        self.imgRate = imgRate
    }
}
