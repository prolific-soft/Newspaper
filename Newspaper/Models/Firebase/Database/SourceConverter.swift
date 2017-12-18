//
//  SourceConverter.swift
//  Newspaper
//
//  Created by Chidi Emeh on 12/18/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation
import Firebase

///This struct converts an Source to anyobject
/// or json ready to be saved on appropriate Firebase
/// branch. It also gets the Firbase snapshot and converts it
/// to a Source

class SourceConverter {
    
    enum FirSourceKey: String {
        case id = "id"
        case name = "name"
        case description = "description"
        case url = "url"
        case category = "category"
        case language = "language"
        case urlsToImage = "urlsToImage"
        case sortBysAvailable = "sortBysAvailable"
    }
    

    /// Converts a datasnapshot to an Article
    func convertSnapshotToArticle(snapshot: DataSnapshot) {

    
    }
    
    /// Converts the article to Firebase ready JSON
    func convertToAny(source : Source) -> Any {
        let jsonEncoder = JSONEncoder()
        var jsonString =  [String: Any]()
        do {
            let jsonData = try jsonEncoder.encode(source)
            jsonString = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            
        }catch let error as NSError {
            print("Error Encoding Source for JSON Conversion : \(error)")
        }
        return jsonString
    }
    
}
