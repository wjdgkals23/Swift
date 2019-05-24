//
//  ViewController.swift
//  PhotoExamples
//
//  Created by 정하민 on 14/05/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit
import Photos

// Photos 프레임워크 : icloud 의

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PHPhotoLibraryChangeObserver {
    
    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var fetchResult: PHFetchResult<PHAsset>! // 결과배열 사진 단위인 PHAsset을 배열로 받을것임
    let imageManager: PHCachingImageManager = PHCachingImageManager() // Asset 데이터를 미리 로딩하는 객체
    let cellIdentifier: String = "cell"
    
    func requestCollection() {
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil) // 앨범에서 컬렉션 단위로 결과를 읽어오는 변수
        
        guard let cameraRollCollection:PHAssetCollection = cameraRoll.firstObject else {
            return
        } // 읽어온 컬렉션 묶음들 중 첫 요소 읽기
        
        let fetchOptions = PHFetchOptions() // 읽어온 컬렉션 데이터를 뽑아낼 옵션 설정
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] // 옵션을 생성날짜로 내림차순으로 정렬
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions) // 데이터 뽑아내기
        
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
            
            PHPhotoLibrary.shared().performChanges({ // Photo 요소 변경 관리 라이브러리를 통한 변화 접근 함수 호출
                PHAssetChangeRequest.deleteAssets([asset] as NSArray) // 변화[삭제] 요청 리퀘스트
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
    
    // MARK: - Segue Prepare
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let imageZoomViewController: ImageZoomViewController = segue.destination as? ImageZoomViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        guard let indexPath: IndexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        imageZoomViewController.imageData = self.fetchResult[indexPath.row]
        
    }

    @IBAction func reloadAction(_ sender: Any) {
        self.requestCollection()
        print("refresh")
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
}


