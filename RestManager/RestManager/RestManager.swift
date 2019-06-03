//
//  RestManager.swift
//  RestManager
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

let didReceiveData: Notification.Name = Notification.Name.init("didReceiveData")
let didReceiveFail: Notification.Name = Notification.Name.init("failReceiveData")

class RestManager {
    var requestHttpHeaders = RestEntity() // 요청해더 생성
    
    var urlQueryParameters = RestEntity() // Get 방식 쿼리생성
    
    var httpBodyParameters = RestEntity() // 잔여 HTTP 메소드 파라미터 생성
    
    var httpBody: Data?
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
            
            var queryItems = [URLQueryItem]()
            for(key,value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)) // URL에 추가될 쿼리 아이템들을 허용되는 문자(빈공백->%20 로 대체)로 인코딩하는 과정
                
                queryItems.append(item)
            }
            urlComponents.queryItems = queryItems
            
            guard let updatedURL = urlComponents.url else { return url }
            return updatedURL
        }
        return url
    }
    
    private func getHttpBody() -> Data? {
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") else { return nil }
        
        if contentType.contains("application/json") {
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys])
        } else if contentType.contains("application/x-www-form-urlencoded") {
            let bodyString = httpBodyParameters.allValues().map { "\($0)=\(String(describing: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))" }.joined(separator: "&")
            return bodyString.data(using: .utf8)
        } else {
            return httpBody
        }
    }
    
    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HttpMethod) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue(value, forHTTPHeaderField: header)
        }
        request.httpBody = httpBody
        return request
    }
    
    func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HttpMethod,
                     completion: @escaping (_ result: Results) -> Void) {
        //@escaping 비동기적으로 또는 함수 밖에서 처리되는 경우 꼭 사용해야함
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            // weak self는 RestManager 인스턴스가 어떤 이유로든 데이터 접근 및 연산의 크래시를 막기 위해서 사용한다.
            // weak로 인핸 self에 접근할때는 optional하게 접근해야한다.
            let targetURL = self?.addURLQueryParameters(toURL: url)
            let httpBody = self?.getHttpBody()
            guard let request = self?.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod) else
            {
                completion(Results(withError: CustomError.failedToCreateRequest))
                return
            }
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: request) { (data, response, error) in
                completion(Results.init(withData: data, response: RestManager.Response(fromURLResponse: response), error: error))
            }
            task.resume()
        }
    }
    
    func sendResponseByNoti(toURL url: URL,
                     withHttpMethod httpMethod: HttpMethod) {
        //@escaping 비동기적으로 또는 함수 밖에서 처리되는 경우 꼭 사용해야함
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            // weak self는 RestManager 인스턴스가 어떤 이유로든 데이터 접근 및 연산의 크래시를 막기 위해서 사용한다.
            // weak로 인핸 self에 접근할때는 optional하게 접근해야한다.
            let targetURL = self?.addURLQueryParameters(toURL: url)
            let httpBody = self?.getHttpBody()
            guard let request = self?.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod) else
            {
                NotificationCenter.default.post(name: didReceiveFail, object: nil, userInfo: ["error":RestManager.CustomError.failedToCreateRequest])
                return
            }
            print(request)
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: request) { (data, response, error) in
                NotificationCenter.default.post(name: didReceiveData, object: nil, userInfo: ["data": data!])
                return
            }
            task.resume()
        }
    }
    
}

extension RestManager {
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
    
    struct RestEntity { // 요청 변수들
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
    
    struct Results {
        var data: Data?
        var response: Response?
        var error: Error?
        
        init (withData data: Data?, response: Response?, error: Error?) { //정상결과 반영
            self.data = data
            self.response = response
            self.error = error
        }
        
        init (withError error: Error) { // 에러반영
            self.error = error
        }
    }
    
    enum CustomError: Error {
        case failedToCreateRequest
    }
}

extension RestManager.CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest: return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        }
    }
}
