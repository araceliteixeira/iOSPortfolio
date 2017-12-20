//
//  Student.swift
//  CollegeProject
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class Student {
    
    private var studentId: Int
    private var name: String
    private var originCountry: CountryEnunm
    private var startDate: Date
    private var endDate: Date
    private var status: Status
    
    init(){
        studentId = 0
        name = ""
        originCountry = CountryEnunm.India
        startDate = Date()
        endDate = Date()
        status = Status.Active
    }
    
    init(_ studentId: Int, _ name: String, _ originCountry: CountryEnunm, _ startDate: String, _ endDate: String, _ status: Status) {
        self.studentId = studentId
        self.name = name
        self.originCountry = originCountry
        self.startDate = Util.convertStringToDate(startDate) ?? Date()
        self.endDate = Util.convertStringToDate(endDate) ?? Date()
        self.status = status
    }
    
    convenience init(_ studentId: Int, _ name: String, _ originCountry: Int, _ startDate: String, _ endDate: String, _ status: Int) {
        self.init(studentId, name, CountryEnunm(rawValue: originCountry)!, startDate, endDate, Status(rawValue: status)!)
    }
    
    func getStudentId() -> Int {
        return studentId
    }
    func getName() -> String {
        return name
    }
    func getOriginCountry() -> CountryEnunm {
        return originCountry
    }
    func getStartDate() -> String {
        return Util.convertDateToString(startDate)
    }
    func getEndDate() -> String {
        return Util.convertDateToString(endDate)
    }
    func getStatus() -> Status {
        return status
    }
    
    func setStudentId(_ studentId:Int) {
        self.studentId = studentId
    }
    func setName(_ name:String) {
        self.name = name
    }
    func setOriginCountry(_ originCountry: CountryEnunm) {
        self.originCountry = originCountry
    }
    func setStartDate(_ startDate: String) {
        self.startDate = Util.convertStringToDate(startDate) ?? Date()
    }
    func setEndDate(_ endDate: String) {
        self.endDate = Util.convertStringToDate(endDate) ?? Date()
    }
    func setStatus(_ status:Status) {
        self.status = status
    }
}
