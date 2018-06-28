//
//  MainViewController.swift
//  RiverRecording
//
//  Created by Marquez on 29/06/2018.
//  Copyright © 2018 Marquez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IGListKit

class MainViewController: ViewController {
    
    private let disposeBag = DisposeBag()
    private lazy var listAdapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    private let photoDataProvider = PhotoDataProvider()

    @IBOutlet weak var wfView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var photoButton: UIButton!
    
    override func initSubviews() {
        super.initSubviews()
        
        let layout = ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .vertical, topContentInset: 0, stretchToEdge: false)
        collectionView.collectionViewLayout = layout
        listAdapter.collectionView = collectionView
        listAdapter.dataSource = self

        photoButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                self.showCamera()
            }).disposed(by: disposeBag)
    }
}

extension MainViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return photoDataProvider.viewModels
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return photoSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// Camera
extension MainViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private func showCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "카메라를 열 수 없습니다.", message: nil, preferredStyle: .alert)
            alertController.show(self, sender: nil)
        }
    }
    
    private func savePhoto(picker: UIImagePickerController, info: [UIImagePickerController.InfoKey: Any]) {
        if let chooseImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoDataProvider.addImage(chooseImage)
            listAdapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            self.savePhoto(picker: picker, info: info)
        }
    }
}

