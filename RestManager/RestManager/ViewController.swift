//
//  ViewController.swift
//  RestManager
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var restManager: RestManager = RestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUser()
    }
    
    func getUser() {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        
        restManager.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userData = try? decoder.decode(UserData.self, from: data) else { return }
                print(userData.description)
            }
            
            print("\n\nResponse HTTP Headers:\n")
            
            if let response = results.response {
                for (key, value) in response.headers.allValues() {
                    print(key, value)
                }
            }
        }
    }
    
    func createUser() {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        
        restManager.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        restManager.httpBodyParameters.add(value: "John", forKey: "name")
        restManager.httpBodyParameters.add(value: "Developer", forKey: "job")
        
        restManager.makeRequest(toURL: url, withHttpMethod: .post) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 201 {
                guard let data = results.data else { return }
                let decoder = JSONDecoder()
                guard let jobUser = try? decoder.decode(JobUser.self, from: data) else { return }
                print(jobUser.description)
            }
        }
    }
}
