//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by 정하민 on 23/05/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellname: String = "cell"
    var cellcount: Int = 10
    var friendsData: [Friends] = Array<Friends>()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellname, for: indexPath) as? CollectionViewCell {
            cell.nameLabel?.text = friendsData[indexPath.row].name + "(" + String(friendsData[indexPath.row].age) + ")"
            cell.nickLabel?.text = friendsData[indexPath.row].address_info.country + ","  + friendsData[indexPath.row].address_info.city
            return cell
        } else {
            print("Cell Init Error")
            return UICollectionViewCell()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.cellcount += 1
//        self.collectionView.reloadData()
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
//        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        
        let halfWidth = UIScreen.main.bounds.width/2.0
        flowLayout.estimatedItemSize = CGSize(width: halfWidth-15, height: 90)
//        flowLayout.headerReferenceSize = CGSize(width: CGFloat(100), height: CGFloat(100)) 헤더 영역 설정
//        flowLayout.itemSize = CGSize(
        
        
        self.collectionView.collectionViewLayout = flowLayout
        
        guard let asset = NSDataAsset(name: "friends") else {
            fatalError("Missing data asset: friends")
        }
        
        let data = asset.data

        let decoder = JSONDecoder()
        do {
            friendsData = try decoder.decode(Array<Friends>.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.collectionView.reloadData()
    }


}

