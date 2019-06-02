//
//  ViewController.swift
//  RestManager
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    
    lazy var restManager: RestManager = RestManager()
    
    @IBOutlet weak var tableView: UITableView!
    var friends: [Friend] = []
    let cellIdentifier: String = "friendCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUser()
    }
    
    func getUser() {
        
        guard let url = URL(string: "https://randomuser.me/api/") else { return }
        restManager.urlQueryParameters.add(value: "20", forKey: "results")
        restManager.urlQueryParameters.add(value: "name,email,picture", forKey: "inc")
        
        restManager.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                guard let userData = try? decoder.decode(APIResponse.self, from: data) else { return }
                print(userData.results.count)
                DispatchQueue.main.async {
                    self.friends = userData.results
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let friend: Friend = friends[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }

            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.imageView?.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
}
