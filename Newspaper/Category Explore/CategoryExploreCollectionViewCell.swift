//
//  CategoryExploreCollectionViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/26/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class CategoryExploreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    //Sets up the cell
    func setUp(name : String, image : UIImage) {
        categoryImage.image = image
        categoryLabel.text = name
    }
    
    
    
}
