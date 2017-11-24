//
//  ArticleConverter.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation
import Firebase

///This struct converts an article to anyobject
/// or json ready to be saved on appropriate Firebase
/// branch. It also gets the Firbase snapshot and converts it
/// to an Article


class ArticleConverter {
    
    
    enum FirArticleKey: String {
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case key = "key"
        case source = "source"
        case addedByUser = "addedByUser"
        case ref = "ref"
        case completed = "completed"
    }
    
    /// Converts a datasnapshot to an Article
    func convertSnapshotToArticle(snapshot: DataSnapshot)-> Article {
        let starArticle = Article()
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        starArticle.author = snapshotValue[FirArticleKey.author.rawValue] as? String
        starArticle.title = snapshotValue[FirArticleKey.title.rawValue] as? String
        starArticle.description = snapshotValue[FirArticleKey.description.rawValue] as? String
        starArticle.url = snapshotValue[FirArticleKey.url.rawValue] as? String
        starArticle.urlToImage = snapshotValue[FirArticleKey.urlToImage.rawValue] as? String
        starArticle.publishedAt = snapshotValue[FirArticleKey.publishedAt.rawValue] as? String
        
        return starArticle
    }
    
    
    
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



