//
//  SourceImages.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/30/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation
import UIKit



// TODO:
// MAKES THIS IMAGES TO BE STORED ON FIREBASE
// SO THAT NEW IMAGES FOR SOURCES WITH THE
// RESPECTIVE KEYS CAN BE ADDED IN THE FIREBASE
// STORAGE AND WILL BE UPDATED ACROSS ALL APPS

//The Source Key and its image
class ImageKey {
    
    let image : UIImage
    let key : String
    
    init(image: UIImage, key: String){
        self.image = image
        self.key = key
    }
    
}


// Holds the sources name key defined in the API
// and the image associated with the source
struct SourceImages {
    
    // Returns a list containing the sources and their
    // images
    func getSourceImages() ->  [ImageKey]{
        var list : [ImageKey]
        list = [
            ImageKey(image: #imageLiteral(resourceName: "abc-news-au"), key: "abc-news-au"), ImageKey(image: #imageLiteral(resourceName: "cnn"), key: "cnn")
        ]
        return list
    }
    
    
    
    
}// End struct Sourceimages








