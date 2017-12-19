//
//  ViewController.swift
//  Activity2
//
//  Created by MacStudent on 2017-10-24.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class VehiclesViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtBrand: UITextField!
    @IBOutlet weak var txtEvaluation: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var buttonCars: UIButton!
    @IBOutlet weak var buttonTrucks: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtBrand.delegate = self
        txtEvaluation.delegate = self
        txtBrand.text = "Renault"
        txtEvaluation.text = "4"
        image.image = UIImage(named: "renault")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        txtBrand.resignFirstResponder()
        txtEvaluation.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.image = selectedImage
            dismiss(animated: true, completion: nil)
        } else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let button = sender as? UIButton {
            if button === buttonCars {
                if let pageViewController = segue.destination as? VehiclesPageViewController {
                    pageViewController.vehicleType = "Cars"
                    pageViewController.vehicles = loadCars()
                } else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            } else if button === buttonTrucks {
                if let pageViewController = segue.destination as? VehiclesPageViewController {
                    pageViewController.vehicleType = "Trucks"
                    pageViewController.vehicles = loadTrucks()
                } else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            }
        }
    }
    
    private func loadCars() -> [Car] {
        var cars: [Car] = []
        cars.append(Car("Clio", 12000.0, UIImage(named: "clio"), false, 4, Rating.Average))
        cars.append(Car("Captur", 15000.0, UIImage(named: "captur"), false, 5, Rating.Good))
        cars.append(Car("Koleos", 18000.0, UIImage(named: "koleos"), false, 5, Rating.Good))
        cars.append(Car("Megane", 20000.0, UIImage(named: "megane"), false, 5, Rating.Excellent))
        return cars
    }

    private func loadTrucks() -> [Truck] {
        var trucks: [Truck] = []
        trucks.append(Truck("Truck 1", 12000.0, UIImage(named: "truck1"), 11, 1000))
        trucks.append(Truck("Truck 2", 15000.0, UIImage(named: "truck2"), 12, 2000))
        trucks.append(Truck("Truck 3", 18000.0, UIImage(named: "truck3"), 13, 3000))
        return trucks
    }
}

