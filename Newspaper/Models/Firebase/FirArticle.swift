//
//  FirebaseArticle.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation
import Firebase

struct FirArticle {
   
    let key: String
    let source: String
    let addedByUser: String
    let ref: DatabaseReference?
    var completed: Bool

    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    
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
    
    //Add init with codable article
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        source = snapshotValue[FirArticleKey.source.rawValue] as! String
        addedByUser = snapshotValue[FirArticleKey.addedByUser.rawValue] as! String
        completed = snapshotValue[FirArticleKey.completed.rawValue ] as! Bool
        ref = snapshot.ref
        
        author = snapshotValue[FirArticleKey.author.rawValue] as! String
        title = snapshotValue[FirArticleKey.title.rawValue] as! String
        description = snapshotValue[FirArticleKey.description.rawValue] as! String
        url = snapshotValue[FirArticleKey.url.rawValue] as! String
        urlToImage = snapshotValue[FirArticleKey.urlToImage.rawValue] as! String
        publishedAt = snapshotValue[FirArticleKey.publishedAt.rawValue] as! String
    }

    func toAnyObject() -> Any {
        return [
            FirArticleKey.source.rawValue : source,
            FirArticleKey.addedByUser.rawValue : addedByUser,
            FirArticleKey.completed.rawValue : completed,
            FirArticleKey.ref.rawValue : ref ?? "",
            FirArticleKey.key.rawValue : key,
            FirArticleKey.author.rawValue : author,
            FirArticleKey.title.rawValue : title,
            FirArticleKey.description.rawValue : description,
            FirArticleKey.url.rawValue : url,
            FirArticleKey.urlToImage.rawValue : urlToImage,
            FirArticleKey.publishedAt.rawValue : publishedAt
        ]
    }
    
}//End Class FirArticle

