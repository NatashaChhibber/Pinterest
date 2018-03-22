//
//  imageCell.swift
//  PinterestLayout_CollectionView
//
//  Created by Appinventiv on 07/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class imageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageVIew: UIImageView!
    override func awakeFromNib() {
        imageVIew.layer.cornerRadius = 6
        imageVIew.layer.masksToBounds = true
    }
}
