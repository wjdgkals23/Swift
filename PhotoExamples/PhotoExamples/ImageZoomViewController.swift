//
//  ImageZoomViewController.swift
//  PhotoExamples
//
//  Created by 정하민 on 20/05/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit
import Photos

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {
    
    // 이미지를 전달받아 로드되는 View
    // Scroll Delegate를 상속받아 정의한다.

    var imageData: PHAsset = PHAsset()
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이미지 데이터 로드
        imageManager.requestImage(for: imageData,
                                  targetSize: CGSize(width: imageView.frame.width, height: imageView.frame.height),
                                  contentMode: .default,
                                  options: nil,
                                  resultHandler: { image, _ in
                                    self.imageView.image = image
        })
        
//        (for: [imageData], targetSize: , contentMode: .default, options: nil)
        // Do any additional setup after loading the view.
    }
    
    // 스크롤시 발동하는 함수
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrolled")
    }
    
    // 줌 대상 설정
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
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
