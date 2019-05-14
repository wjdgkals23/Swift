//
//  ViewController.swift
//  PhotoExamples
//
//  Created by 정하민 on 14/05/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PHPhotoLibraryChangeObserver {
    
    @IBOutlet weak var tableView: UITableView!
    var fetchResult: PHFetchResult<PHAsset>! // 결과배열
    let imageManager: PHCachingImageManager = PHCachingImageManager() // 가져온 핸드폰 앨범의 사진데이터를 셀 이미지에 대입하는 요소
    let cellIdentifier: String = "cell"
    
    func requestCollection() {
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil) // 회원 앨범에 접근하여 컬렉션 별로 읽어오기
        
        guard let cameraRollCollection:PHAssetCollection = cameraRoll.firstObject else {
            return
        } // 읽어온 컬렉션 묶음들 중 첫 요소 읽기
        
//        print(cameraRoll.count)
        
        let fetchOptions = PHFetchOptions() // 읽어온 컬렉션 정렬 옵션 생성
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] // 생성날짜로 정렬
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
        // 콜렉션을 PHAsset.fetchAssets 를 이용하여 PHAsset이 원소인 배열로 변경
        
        PHPhotoLibrary.shared().register(self)
        // 변화에 대한 감지를 해당 부분에 놓아야하는 이유는 최초 접근시 데이터에 대한 변화가 차후에 일어날 수 있다.
        // 활용할 데이터가 ! 이기 때문에 초기에 nil일 경우 접근하면 에러가 발생
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoAurthorizationStatus = PHPhotoLibrary.authorizationStatus() //사용자 앨범 접근권한 확인
        
        switch photoAurthorizationStatus {
        case .authorized:
            print("접근 허가")
            self.requestCollection()
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        case .denied:
            print("접근 거부")
        case .notDetermined:
            print("응답 전")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                    case .authorized:
                        print("사용자 접근 허가")
                        self.requestCollection()
                        OperationQueue.main.addOperation {
                            self.tableView.reloadData()
                        }
                    case .denied:
                        print("사용자 접근 불허가")
                    
                    default: break
                }
            })
        case .restricted:
            print("접근 제한")
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: {
            image, _ in cell.imageView?.image = image
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let asset: PHAsset = self.fetchResult[indexPath.row]
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.deleteAssets([asset] as NSArray)
            }, completionHandler: nil) // 취소 리퀘스트
        }
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        
        fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }
    }
    
}


