//
//  ArticleConverter.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation

///This struct converts an article to anyobject
/// or json ready to be saved on appropriate Firebase
/// branch. It also gets the Firbase snapshot and converts it
/// to an Article


class ArticleConverter {
    
    
    
    
    
    
    /// Converts the article to Firebase ready JSON
    func convertToAny(article : Article) -> Any {
        
        let jsonEncoder = JSONEncoder()
        var jsonString =  [String: Any]()
        do {
            let jsonData = try jsonEncoder.encode(article)
            jsonString = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            
        }catch let error as NSError {
            print("Error Encoding Article for JSON Conversion : \(error)")
        }
        return jsonString
    }
    
}



