//
//  Extensions.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/3/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    typealias IMAGEResult = ( (UIImage?) -> Void  )
    
    func downloadImageFromUrl(url : URL , completion : @escaping IMAGEResult) {
        
        let imageDownloader = NetworkProcessor(url: url)
        
        imageDownloader.downloadImageDataFromURL { (imageData, response, error) in
            
            DispatchQueue.main.async {
                if let data = imageData {
                    completion(UIImage(data: data)!)
                }
            }
        }
        
        
    }
    
    
    
}
