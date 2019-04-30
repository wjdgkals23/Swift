//
//  ViewController.swift
//  GCDPractice
//
//  Created by 정하민 on 30/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inactiveExample()
//        concurrentExample()
        fetchImage()
        print("after did appear")
        
        if let queue = inactiveMainQueue {
            queue.activate()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func simpleQueues() { // queue 를 이용한 excution code 실행 예제
        let queue = DispatchQueue(label: "com.appcoda.myqueue")
        
        queue.async {
            for i in 0..<10 {
                print("# ", i)
            }
        }
        
        for i in 100..<110 {
            print("$ ", i)
        }
    }
    
    func qosExample() { // Qos를 이용한 작업 우선순위 지정
        let queue1 = DispatchQueue(label: "com.hamin.quque1", qos: .utility)
        let queue2 = DispatchQueue(label: "com.hamin.quque2", qos: .userInitiated)
        
        queue1.async {
            for i in 1..<10 {
                print("% ", i)
            }
        }
        queue2.async {
            for i in 100..<110 {
                print("& ", i)
            }
        }
        
        for i in 1000..<1010 {
            print("^ ", i)
        }
    }
    
    func concurrentExample() { // 병렬 처리 예제
        let concurrentQueue = DispatchQueue(label: "com.hamin.concurrent", qos: .utility, attributes: .concurrent)
//        let concurrentQueue = DispatchQueue(label: "com.hamin.concurrent", qos: .utility)
        
        concurrentQueue.async {
            for i in 0..<10 {
                print("$$ ", i)
            }
        }
        
        concurrentQueue.async {
            for i in 1000..<1010 {
                print("## ", i)
            }
        }
        
        concurrentQueue.async {
            for i in 100..<110 {
                print("%% ", i)
            }
        }
    }
    
    var inactiveMainQueue: DispatchQueue! = DispatchQueue(label: "empty")
    
    func inactiveExample() {
        let inactiveQueue = DispatchQueue(label: "com.hamin.inactive", qos: .utility, attributes: [.initiallyInactive, .concurrent])
        inactiveMainQueue = inactiveQueue
        
        inactiveQueue.async {
            for i in 0..<10 {
                print("!! ", i)
            }
        }
        
        inactiveQueue.async {
            for i in 100..<110 {
                print("** ", i)
            }
        }
    }
    
    func fetchImage() {
        let imageURL: URL = URL(string: "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!
        
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            
            if let data = imageData {
                print("Did download image data")
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                    
                }
            }
        }).resume()
    }

}

