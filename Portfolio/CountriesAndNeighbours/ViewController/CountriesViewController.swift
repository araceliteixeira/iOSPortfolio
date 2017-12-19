//
//  ViewController.swift
//  Assignment2
//
//  Created by Araceli Teixeira on 30/10/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit
import MapKit

class CountriesViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickContinent: UIPickerView!
    @IBOutlet weak var txtCountry2: UITextField!
    @IBOutlet weak var txtCountry1: UITextField!
    @IBOutlet weak var pickCountry1: UIPickerView!
    @IBOutlet weak var pickCountry2: UIPickerView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var btnShowDistances: UIButton!
    
    var annotations : [MKPointAnnotation] = []
    var countries: [Country] = []
    var continents: [String] = []
    var neighbours: [Country] = []
    var pickCountriesData: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countries = loadCountries()!
        setNeighbours()
        loadContinents()
        
        txtCountry1.delegate = self
        txtCountry2.delegate = self
        pickContinent.delegate = self
        pickContinent.dataSource = self
        pickCountry1.delegate = self
        pickCountry1.dataSource = self
        pickCountry1.isHidden = true
        pickCountry2.delegate = self
        pickCountry2.dataSource = self
        pickCountry2.isHidden = true
        
        map.delegate = self
        btnShowDistances.isEnabled = false
        
        pickContinent.selectRow(0, inComponent: 0, animated: false)
        pickCountriesData = getCountriesFromContinent(continents[0])
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtCountry1 {
            self.view.bringSubview(toFront: pickCountry1)
            pickCountry1.isHidden = !pickCountry1.isHidden
            pickCountry2.isHidden = true
        } else if textField == txtCountry2 {
            self.view.bringSubview(toFront: pickCountry2)
            pickCountry2.isHidden = !pickCountry2.isHidden
            pickCountry1.isHidden = true
        }
        //textField.endEditing(true)
        textField.resignFirstResponder()
    }
    
    //MARK: PickerView delegate and data source methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickContinent {
            return continents.count
        } else {
            return pickCountriesData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickContinent {
            return continents[row]
        } else {
            return pickCountriesData[row].countryName
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickContinent {
            pickCountriesData = getCountriesFromContinent(continents[row])
            pickCountry1.reloadComponent(0)
            pickCountry1.selectRow(0, inComponent: 0, animated: false)
            txtCountry1.text = ""
            pickCountry2.reloadComponent(0)
            pickCountry2.selectRow(0, inComponent: 0, animated: false)
            txtCountry2.text = ""
        } else if pickerView == pickCountry1 {
            txtCountry1.text = pickCountriesData[row].countryName
            txtCountry1.resignFirstResponder()
            pickCountry1.isHidden = true
        } else if pickerView == pickCountry2 {
            txtCountry2.text = pickCountriesData[row].countryName
            txtCountry2.resignFirstResponder()
            pickCountry2.isHidden = true
        }
        btnShowDistances.isEnabled = false
    }
    
    //MARK: Load data
    
    struct CountryData: Decodable {
        var countries: [Country]
    }
    
    func loadCountries() -> [Country]? {
        if let url = Bundle.main.url(forResource: "countries", withExtension: "json", subdirectory: "Assets") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CountryData.self, from: data)
                return jsonData.countries.sorted(by: {$0.countryName < $1.countryName})
            } catch {
                print("error: \(error)")
            }
        } else {
            fatalError("File countries.json not found")
        }
        return nil
    }
    
    struct NeighbourData: Decodable {
        var countriesNeighbours: [CountriesNeighbours]
    }
    
    struct CountriesNeighbours: Decodable {
        var country: String
        var neighbours: [String]
    }
    
    func loadNeighbours() -> [CountriesNeighbours]? {
        if let url = Bundle.main.url(forResource: "neighbours", withExtension: "json", subdirectory: "Assets") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NeighbourData.self, from: data)
                return jsonData.countriesNeighbours
            } catch {
                print("error: \(error)")
            }
        } else {
            fatalError("File neighbours.json not found")
        }
        return nil
    }
    
    func setNeighbours() {
        for c in loadNeighbours()! {
            let country = Country.findCountryByCode(countries, c.country)
            if country != nil {
                for neighbour in c.neighbours {
                    let n = Country.findCountryByCode(countries, neighbour)
                    if n != nil {
                        country!.addNeighbour(n!)
                    }
                }
            }
        }
    }
    
    func loadContinents() {
        for c in countries {
            if !continents.contains(c.continentName) {
                continents.append(c.continentName)
            }
        }
        continents = continents.sorted(by: {$0 < $1})
    }
    
    func getCountriesFromContinent(_ continent: String) -> [Country] {
        var countriesInContinent: [Country] = []
        for c in countries {
            if c.continentName == continent {
                countriesInContinent.append(c)
            }
        }
        return countriesInContinent
    }
    
    //MARK: Actions
    
    @IBAction func findNeighbours(_ sender: UIButton) {
        txtCountry1.resignFirstResponder()
        txtCountry2.resignFirstResponder()
        if txtCountry1.text == "" || txtCountry2.text == "" {
            showMessage("There must be two countries selected")
            return
        }
        let country1 = Country.findCountryByName(countries, txtCountry1.text!)
        if country1 == nil {
            showMessage("\(txtCountry1.text!) is not a valid country")
            return
        }
        let country2 = Country.findCountryByName(countries, txtCountry2.text!)
        if country2 == nil {
            showMessage("\(txtCountry2.text!) is not a valid country")
            return
        }
        if country1 == country2 {
            showMessage("Please choose two different countries")
            return
        }
        
        map.removeAnnotations(annotations)
        annotations = []
        
        let country1Annotation = CustomPointAnnotation(UIColor.blue)
        country1Annotation.title = country1!.countryName
        country1Annotation.subtitle = country1!.capitalName
        country1Annotation.coordinate = CLLocationCoordinate2DMake(country1!.capitalLatitude, country1!.capitalLongitude)
        map.addAnnotation(country1Annotation)
        annotations.append(country1Annotation)
        
        let country2Annotation = CustomPointAnnotation(UIColor.blue)
        country2Annotation.title = country2!.countryName
        country2Annotation.subtitle = country2!.capitalName
        country2Annotation.coordinate = CLLocationCoordinate2DMake(country2!.capitalLatitude, country2!.capitalLongitude)
        map.addAnnotation(country2Annotation)
        annotations.append(country2Annotation)
        
        neighbours = country1!.neighboursInCommon(country2!).sorted(by: {$0.countryName < $1.countryName})
        if neighbours.count == 0 {
            showMessage("No country is neighbour of both \(country1!.countryName) and \(country2!.countryName)")
        } else {
            for c in neighbours {
                let neighbourAnnotation = CustomPointAnnotation(UIColor.red)
                neighbourAnnotation.title = c.countryName
                neighbourAnnotation.subtitle = c.capitalName
                neighbourAnnotation.coordinate = CLLocationCoordinate2DMake(c.capitalLatitude, c.capitalLongitude)
                map.addAnnotation(neighbourAnnotation)
                annotations.append(neighbourAnnotation)
            }
        }
        map.showAnnotations(annotations, animated: true)
        btnShowDistances.isEnabled = true
        
        neighbours.insert(country2!, at: 0)
        neighbours.insert(country1!, at: 0)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "marker"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            view?.annotation = annotation
        }
        let customPointAnnotation = annotation as! CustomPointAnnotation
        view?.markerTintColor = customPointAnnotation.pointColor
        view?.titleVisibility = .visible
        return view
    }
    
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDistances" {
            let view = segue.destination as! DistancesViewController
            view.distances = calculateDistances()
        }
     }
    
    func calculateDistances() -> [(String, String, Int)]{
        var distances: [(String, String, Int)] = []
        for i in 0...neighbours.count-2 {
            for j in i+1...neighbours.count-1 {
                let d: (String, String, Int)
                d.0 = neighbours[i].countryName
                d.1 = neighbours[j].countryName
                d.2 = distanceBetweenCountries(neighbours[i], neighbours[j])
                distances.append(d)
            }
        }
        return distances
    }
    
    func distanceBetweenCountries(_ country1: Country, _ country2: Country) -> Int {
        let coordinate1 = CLLocation(latitude: country1.capitalLatitude, longitude: country1.capitalLongitude)
        let coordinate2 = CLLocation(latitude: country2.capitalLatitude, longitude: country2.capitalLongitude)
        return Int(coordinate1.distance(from: coordinate2))/1000
    }
    
    @IBAction func backToMainScreen(unwindSegue: UIStoryboardSegue) {
    }
}

