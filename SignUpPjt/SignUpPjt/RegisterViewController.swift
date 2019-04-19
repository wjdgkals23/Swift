//
//  RegisterViewController.swift
//  SignUpPjt
//
//  Created by 정하민 on 16/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var chpwTextField: UITextField!
    @IBOutlet var introTextView: UITextView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var userInfo: UserInfo? = UserInfo.sharedInstance;
    let imagePicker: UIImagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let tapRecognizer: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chImage(_:)))
        tapRecognizer.delegate = self
        imageView.addGestureRecognizer(tapRecognizer)
        
        imagePicker.delegate = self
        
//        chpwTextField.delegate = self
        
        nextButton.backgroundColor = UIColor.red
        nextButton.isEnabled = false;
        
        chpwTextField.addTarget(self, action: #selector(chPwSame), for: UIControl.Event.editingChanged)
        
//        self.view.addGestureRecognizer(tapRecognizer)
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let temp: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(temp)
            imageView.image = temp
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Action
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chImage(_ sender: UIImageView) {
        present(imagePicker, animated: true, completion: nil)
    }
 
    @IBAction func nextAction(_ sender: Any) {
        print("next")
        if let exUser = userInfo {
            exUser.userId = idTextField.text
            exUser.userPw = chpwTextField.text
            exUser.userIntro = introTextView.text
        }
    }
    
    @objc func chPwSame() {
        print("chPwSame")
        if(chpwTextField.text == pwTextField.text) {
            nextButton.backgroundColor = UIColor.white
            nextButton.isEnabled = true;
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }
    
    
// 글자 같은지 맞추기에는 싱크가 안 맞음
// MARK: - TextFieldDelegate
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print(textField)
//        if (chpwTextField.text == pwTextField.text) {
//            nextButton.backgroundColor = UIColor.blue
//            nextButton.isEnabled = true;
//        }
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if(textField.text == "") {
//            return true
//        }
//        else {
//            if (textField.text == pwTextField.text) {
//                nextButton.backgroundColor = UIColor.blue
//                nextButton.isEnabled = true;
//            } else {
//                nextButton.backgroundColor = UIColor.red
//                nextButton.isEnabled = false;
//            }
//        }
//        return true;
//    }

    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//
//        if(textField.text == "") {
//            return true
//        }
//        else {
//            if (textField.text == pwTextField.text) {
//                nextButton.backgroundColor = UIColor.blue
//                nextButton.isEnabled = true;
//            } else {
//                nextButton.backgroundColor = UIColor.red
//                nextButton.isEnabled = false;
//            }
//        }
//        return true;
//
//    }
    
    /*
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
