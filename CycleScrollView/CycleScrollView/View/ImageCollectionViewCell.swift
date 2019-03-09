//
//  ImageCollectionViewCell.swift
//  CycleScrollView
//
//  Created by 白野 on 2019/3/9.
//  Copyright © 2019 白野. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func set(withImageURLString imageURLString: String?) {
        if let imageURLString = imageURLString {
            self.imageView.sd_setImage(with: URL(string: imageURLString), completed: nil)
        } else {
            self.imageView.image = nil
        }
    }
}
