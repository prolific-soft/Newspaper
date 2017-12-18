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
        case urlsToLogos = "urlsToLogos"
        case sortBysAvailable = "sortBysAvailable"
    }
    

    /// Converts a datasnapshot to a Source
    func convertSnapshotToArticle(snapshot: DataSnapshot) -> Source {
        let subscribedSource = Source()
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        subscribedSource.id = snapshotValue[FirSourceKey.id.rawValue] as? String
        subscribedSource.name = snapshotValue[FirSourceKey.name.rawValue] as? String
        subscribedSource.description = snapshotValue[FirSourceKey.description.rawValue] as? String
        subscribedSource.url = snapshotValue[FirSourceKey.url.rawValue] as? String
        subscribedSource.category = snapshotValue[FirSourceKey.category.rawValue] as? String
        subscribedSource.language = snapshotValue[FirSourceKey.language.rawValue] as? String
        subscribedSource.urlsToLogos = snapshotValue[FirSourceKey.urlsToLogos.rawValue] as? urlsToLogos
        subscribedSource.sortBysAvailable = snapshotValue[FirSourceKey.sortBysAvailable.rawValue] as? [String]
        
        return subscribedSource
    
    }
    
    /// Converts the Source to Firebase ready JSON
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
