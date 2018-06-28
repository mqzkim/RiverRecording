//
//  PhotoDataProvider.swift
//  RiverRecording
//
//  Created by Marquez on 29/06/2018.
//  Copyright © 2018 Marquez. All rights reserved.
//

import UIKit

class PhotoDataProvider {
    var viewModels: [PhotoViewModel] = []
    
    func addImage(_ image: UIImage) {
        viewModels.append(PhotoViewModel(image))
        
    }
}
