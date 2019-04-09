//
//  ViewController.swift
//  DataSourceSwift
//
//  Created by 정하민 on 09/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    let companyData: [String] = ["Tesla","Lambo"]
    var imageData: [String] = [String]()
    var nameData: [String] = [String]()
    let imageTesla: [String] = [
        "tesla-model-s.jpg",
        "tesla-model-x.jpg"]
    let nameTesla: [String] = ["models","modelx"]
    let imageLambo: [String] = ["lamborghini-aventador.jpg",
        "lamborghini-huracan.jpg",
        "lamborghini-veneno.jpg"]
    let nameLambo: [String] = ["aventador","hurcan", "veneno"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        imageData = imageTesla
        nameData = nameTesla
        self.imageView.image = UIImage.init(named: imageData[0])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return companyData.count
        } else {
            return nameData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return companyData[row]
        } else {
            return nameData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if row == 0 {
                nameData = nameTesla
                imageData = imageTesla
            } else {
                nameData = nameLambo
                imageData = imageLambo
            }
            pickerView.reloadAllComponents()
            print(pickerView.selectedRow(inComponent: 1))
            imageView.image = UIImage.init(named: imageData[pickerView.selectedRow(inComponent: 1)])
        } else {
            imageView.image = UIImage.init(named: imageData[row])
        }
    }

}

