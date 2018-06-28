//
//  PhotoCell.swift
//  RiverRecording
//
//  Created by Marquez on 29/06/2018.
//  Copyright © 2018 Marquez. All rights reserved.
//

import UIKit
import SnapKit

class PhotoCell: UICollectionViewCell {
    static let height = UIScreen.main.bounds.size.width / 4
    
    var viewModel: PhotoViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            imageView.image = viewModel.image
        }
    }
    
    lazy var imageView: UIImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCell {
    func bindViewModel(_ viewModel: PhotoViewModel) {
        self.viewModel = viewModel
    }
}
