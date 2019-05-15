//
//  UrlSetter.swift
//  OperationQueueExample
//
//  Created by 정하민 on 15/05/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import Foundation

class UrlSetter {
    let urlString: String
    let realUrl: URL?
    
    func getImageData() -> Data {
        var imageData: Data = Data()
        do {
            if let getUrl = self.realUrl {
                imageData = try Data(contentsOf: getUrl)
            }
        } catch {
            print("Image Data Load Error \(error)")
        }
        return imageData
    }
    
    init(urlString: String) {
        self.urlString = urlString
        self.realUrl = URL(string: self.urlString)
    }
}
