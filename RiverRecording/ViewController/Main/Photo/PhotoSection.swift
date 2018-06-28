//
//  PhotoSection.swift
//  RiverRecording
//
//  Created by Marquez on 29/06/2018.
//  Copyright © 2018 Marquez. All rights reserved.
//

import Foundation
import IGListKit

class PhotoViewModel {
    var image: UIImage
    var title: String?
    
    init(_ image: UIImage, title: String? = nil) {
        self.image = image
        self.title = title
    }
}

extension PhotoViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return "PhotoViewModel_\(image.hashValue)_\(self.title ?? "")" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if object === self { return true }
        guard let object = object as? PhotoViewModel else { return false }
        if object.image == image,
            object.title == title { return true }
        return false
    }
}

func photoSectionController() -> ListSingleSectionController {
    let configureBlock = { (viewModel: Any, cell: UICollectionViewCell) in
        guard let viewModel = viewModel as? PhotoViewModel else { return }
        guard let cell = cell as? PhotoCell else { return }
        cell.bindViewModel(viewModel)
    }
    
    let sizeBlock = { (viewModel: Any, context: ListCollectionContext?) -> CGSize in
        guard let context = context else { return .zero }
        return CGSize(width: PhotoCell.height, height: PhotoCell.height)
    }
    
    return ListSingleSectionController(
        cellClass: PhotoCell.self,
        configureBlock: configureBlock,
        sizeBlock: sizeBlock
    )
}
