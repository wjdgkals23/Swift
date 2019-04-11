//
//  ViewController.swift
//  NavigationPractice
//
//  Created by 정하민 on 11/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {

//    let photo = PHPhotoLibrary.authorizationStatus()
    let image = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        image.delegate = self
    }

    @IBAction func galleryOpen(_ sender: UIButton) {
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("end picker")
        picker.dismiss(animated: true, completion: nil)
    }
}

