//
//  ViewController.swift
//  HappyHalloween
//
//  Created by Macstudent on 2017-10-31.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class HalloweenViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCandies: UITextField!
    @IBOutlet weak var imgHouse: UIImageView!
    @IBOutlet weak var imgRate: UIImageView!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    var house: House?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        txtAddress.delegate = self
        txtCandies.delegate = self
        
        btnSave.isEnabled = false
        
        if let existHouse = house {
            navigationItem.title = existHouse.address
            txtAddress.text = existHouse.address
            txtCandies.text = String(existHouse.numberOfCandies)
            imgHouse.image = existHouse.imgHouse
            imgRate.image = existHouse.imgRate
        }
    }
    
    func updateSaveButtonState() {
        if let text = txtAddress.text {
            btnSave.isEnabled = !text.isEmpty
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        if textField == txtAddress {
            navigationItem.title = textField.text!
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateSaveButtonState()
        if textField == txtCandies {
            var new_number = -1
            if range.length > 0 && Int(txtCandies.text!) != nil {
                new_number = Int(txtCandies.text!)! / 10
            } else if Int(string) != nil {
                new_number = Int(txtCandies.text! + string)!
            }
            if new_number >= 0 {
                if new_number >= 5 {
                    imgRate.image = UIImage(named: "happy")
                } else if new_number <= 1 {
                    imgRate.image = UIImage(named: "sad")
                } else {
                    imgRate.image = UIImage(named: "neutral")
                }
            } else {
                return false
            }
        }
        return true
    }
    
    // MARK: Image View Delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgHouse.image = selectedImage
            updateSaveButtonState()
            dismiss(animated: true, completion: nil)
        }else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIBarButtonItem {
            if button === btnSave {
                if !(txtAddress.text?.isEmpty)! {
                    house = House(txtAddress.text!, Int(txtCandies.text ?? "0")!, imgHouse.image)
                }
            }
        }
    }

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        txtAddress.resignFirstResponder()
        txtCandies.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func buttonCancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddHouseMode = presentingViewController is UINavigationController && navigationController != nil && navigationController?.restorationIdentifier == "HalloweenNavigationController"
        if isPresentingInAddHouseMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
    }
    
}

