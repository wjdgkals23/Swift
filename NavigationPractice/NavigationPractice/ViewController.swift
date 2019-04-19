//
//  ViewController.swift
//  NavigationPractice
//
//  Created by 정하민 on 11/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var ageField: UITextField!
    @IBOutlet var saveShared: UIButton!
    
//    let photo = PHPhotoLibrary.authorizationStatus()
    let image = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        image.delegate = self
        print("ViewController Did Load")
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
    @IBAction func saveUserInfo(_ sender: Any) {
        UserInfo.shared.name = nameField.text
        UserInfo.shared.age = ageField.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController Will Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController Will Disappear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController Did Appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController Did Disappear")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ViewController Subview Did Appear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("ViewController Subview Will Appear")
    }

}

