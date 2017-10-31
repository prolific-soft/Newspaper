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
        
        //Temporary Fix for Special case
        //String in the cell category label
//        var tempLabel = ""
//        switch name {
//        case "Technology":
//            tempLabel = "Tech"
//        case "science-and-nature":
//            tempLabel = "Science"
//        case "sport":
//            tempLabel = "Sports"
//        default:
//            tempLabel = name
//        }
//
        categoryImage.image = image
        categoryLabel.text = name
    }
    
    
    
}
