//
//  TrucksViewController.swift
//  Activity2
//
//  Created by Araceli Teixeira on 25/10/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class TrucksViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtSize: UITextField!
    @IBOutlet weak var txtVolume: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var truck: Truck!
    var pageIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtName.text = truck.name
        txtPrice.text = String(truck.price)
        txtSize.text = String(truck.size)
        txtVolume.text = String(truck.volume)
        image.image = truck.image
    }

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        txtName.resignFirstResponder()
        txtPrice.resignFirstResponder()
        txtSize.resignFirstResponder()
        txtVolume.resignFirstResponder()
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
