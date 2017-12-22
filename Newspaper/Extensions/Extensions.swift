//
//  Extensions.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/3/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation
import SVProgressHUD
import UIKit

extension UIImageView {
    
    typealias IMAGEResult = ( (UIImage?) -> Void  )
    
    func downloadImageFromUrl(url : URL , completion : @escaping IMAGEResult) {
        
        let imageDownloader = NetworkProcessor(url: url)
        
        imageDownloader.downloadImageDataFromURL { (imageData, response, error) in
            
            DispatchQueue.main.async {
                guard let data = imageData else { return }
                guard let image = UIImage(data: data) else {
                    SVProgressHUD.setDefaultMaskType(.black)
                    SVProgressHUD.setMinimumSize(CGSize(width: 100, height: 200))
                    SVProgressHUD.setMinimumDismissTimeInterval(1.8)
                    SVProgressHUD.showSuccess(withStatus: "Some images are missing")
                    return
                }
                completion(image)
            }
        }
    }
}
