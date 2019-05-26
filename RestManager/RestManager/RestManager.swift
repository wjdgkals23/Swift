//
//  RestManager.swift
//  RestManager
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

class RestManager {
    var requestHttpHeaders = RestEntity() // 요청해더 생성
    
    var urlQueryParameters = RestEntity() // Get 방식 쿼리생성
    
    var httpBodyParameters = RestEntity() // 잔여 HTTP 메소드 파라미터 생성
}

extension RestManager {
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
    
    struct RestEntity {
        private var values: [String:String] = [:]
        
        mutating func add(value:String, forKey key:String) { // mutating 구조체의 내부속성을 변경하기 위해 필수
            values[key] = value
        }
        
        func value(forKey key:String) -> String? {
            return values[key]
        }
        
        func allValues() -> [String: String] {
            return values
        }
        
        func totalItems() -> Int {
            return values.count
        }
    }
    
    struct Response {
        var response: URLResponse?
        var httpStatusCode: Int = 0
        var headers = RestEntity()
        
        init(fromURLResponse response: URLResponse?) {
            guard let response = response else { return }
            self.response = response
            self.httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
                for (key, value) in headerFields {
                    headers.add(value: "\(value)", forKey: "\(key)")
                }
            }
        }
    }
}
