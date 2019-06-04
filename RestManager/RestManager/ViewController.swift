//
//  ViewController.swift
//  RestManager
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    lazy var restManager: RestManager = RestManager()
    
    @IBOutlet weak var tableView: UITableView!
    var friends: [Friend] = []
    let cellIdentifier: String = "phonecell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isEditing = true
//        getUser()
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveDataFunc(_:)), name: didReceiveData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveFailFunc(_:)), name: didReceiveFail, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        getUser()
        getUserByNoti()
    }
    
    @objc func didReceiveDataFunc(_ noti:Notification) {
        if let data = noti.userInfo {
            let decoder = JSONDecoder()
            guard let userData = try? decoder.decode(APIResponse.self, from: data["data"] as! Data) else { return }
            DispatchQueue.main.async {
                self.friends = userData.results
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func didReceiveFailFunc(_ noti:Notification) {

        let alertAction: UIAlertController = UIAlertController.init(title: "에러", message: "데이터로드 에러", preferredStyle: UIAlertController.Style.alert)
        let okAction: UIAlertAction = UIAlertAction.init(title: "확인", style: UIAlertAction.Style.cancel, handler: nil)
        let redirectAction: UIAlertAction = UIAlertAction.init(title: "재로드", style: UIAlertAction.Style.default) { [unowned self] (action) in
            self.getUser()
        }
        alertAction.addAction(okAction)
        alertAction.addAction(redirectAction)
        self.present(alertAction, animated: false, completion: nil)
    }
    
    func getUserByNoti() {
        guard let url = URL(string: "https://randomuser.me/api/") else { return }
        restManager.urlQueryParameters.add(value: "20", forKey: "results")
        restManager.urlQueryParameters.add(value: "name,email,picture", forKey: "inc")
        restManager.sendResponseByNoti(toURL: url, withHttpMethod: .get)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PhoneCell
        let friend: Friend = friends[indexPath.row]
        cell.imgView.image = nil
        cell.infoLabel.text = friend.email
        cell.nameLabel.text = friend.name.full
//        cell.textLabel?.text = friend.name.full
//        cell.detailTextLabel?.text = friend.email
//        cell.imageView?.image = nil
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }

            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.imgView?.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            friends.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.friends[sourceIndexPath.row]
        friends.remove(at: sourceIndexPath.row)
        friends.insert(movedObject, at: destinationIndexPath.row)
    }
}
