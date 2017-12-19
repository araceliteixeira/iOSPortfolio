//
//  CarsViewController.swift
//  Activity2
//
//  Created by Araceli Teixeira on 25/10/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class CarsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var switchEletric: UISwitch!
    @IBOutlet weak var txtCapacity: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var image: UIImageView!
    
    var car: Car!
    var pageIndex: Int = 0
    let pickerValues = [Rating.Excellent, Rating.Good, Rating.Average, Rating.Bad]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtName.text = car.name
        txtPrice.text = String(car.price)
        switchEletric.isOn = car.isElectric
        txtCapacity.text = String(car.capacity)
        pickerView.selectRow(car.rating.rawValue, inComponent: 0, animated: false)
        image.image = car.image
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: pickerValues[row])
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        txtName.resignFirstResponder()
        txtPrice.resignFirstResponder()
        txtCapacity.resignFirstResponder()
        
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
}
