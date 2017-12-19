//
//  Country.swift
//  Assignment2
//
//  Created by Araceli Teixeira on 30/10/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import Foundation

class Country: Decodable, Equatable {
    
    static func ==(lhs: Country, rhs: Country) -> Bool {
        return lhs.countryCode == rhs.countryCode
    }
    
    var countryName: String
    var capitalName: String
    var capitalLatitude: Double
    var capitalLongitude: Double
    var countryCode: String
    var continentName: String
    var neighbours: [Country]?
    
    init() {
        countryName = ""
        capitalName = ""
        capitalLatitude = 0.0
        capitalLongitude = 0.0
        countryCode = ""
        continentName = ""
    }
    
    static func findCountryByCode(_ countries: [Country], _ countryCode: String) -> Country? {
        for c in countries {
            if c.countryCode == countryCode {
                return c
            }
        }
        return nil
    }
    
    static func findCountryByName(_ countries: [Country], _ countryName: String) -> Country? {
        for c in countries {
            if c.countryName == countryName {
                return c
            }
        }
        return nil
    }
    
    func addNeighbour(_ country: Country) {
        if neighbours == nil {
            neighbours = []
        }
        if country != self && !isNeighbour(country){
            (neighbours!).append(country)
        }
    }
    
    func isNeighbour(_ country: Country) -> Bool {
        for c in neighbours! {
            if country == c {
                return true
            }
        }
        return false
    }
    
    func neighboursInCommon(_ country: Country) -> [Country] {
        var neighboursInCommon: [Country] = []
        if neighbours != nil && country.neighbours != nil {
            for c in country.neighbours! {
                if isNeighbour(c) {
                    neighboursInCommon.append(c)
                }
            }
        }
        return neighboursInCommon
    }
}
