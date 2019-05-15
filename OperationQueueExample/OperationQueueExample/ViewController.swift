//
//  ViewController.swift
//  OperationQueueExample
//
//  Created by 정하민 on 15/05/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var loadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loadAction(_ sender: Any) {
        let urlSetter = UrlSetter(urlString: "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg")
        OperationQueue().addOperation {
            OperationQueue.main.addOperation {
                self.ImageView.image = UIImage(data: urlSetter.getImageData())
            }
        }
    }
    
}

