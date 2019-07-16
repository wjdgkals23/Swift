//
//  ImageViewController.swift
//  Caccini
//
//  Created by 정하민 on 16/07/2019.
//  Copyright © 2019 HMJeong. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var imageURL: URL? {
        didSet {
            imageView.image = nil
            if view.window != nil { // 화면이 로딩되었을 때 view의 window에 접근 가능하다.
                fetchImage()
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if view.window != nil {
            fetchImage()
        }
        scrollView.bounces = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.NASA["Cassini"]
        }
        // Do any additional setup after loading the view.
    }
    
    private func fetchImage() {
        if let url = imageURL {
            DispatchQueue.global().async {
                let urlContents = try? Data(contentsOf: url) // try? 를 통해서 do catch를 진행하지 않아도 URL 로드 실패시 nil을 반환
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self.imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
