//
//  StarsApi.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

/// The branch or node on the Firbase
/// database that holds the users stared articles

class StarsApi {
    
    /// The current user that owns the star branch
    var user : User?
    var starBranch = StarsApi()
    
    /// Initialized with the current user
    init(user: User) {
        self.user = user
    }
    
    /// Init overload to be used in Singleton class
    /// FirA
    init(){
        
    }
    
    var REF_STARS = UserApi.REF_CURRENT_USER?.child("stars")

    /// Returns the "stars" branch/node on the Firebase database
    /// based on the current user signed in. This will be Used to
    /// save Starred Articles to the "stars" branch/node
    func getStarREF()-> DatabaseReference? {
        guard let currentUser = self.user else {
            return nil
        }
        return UserApi.REF_USERS.child(currentUser.uid).child("stars")
    }
    
    /// Observe branch and returns an array of Starred Articles
    func observeUserStarredArticles(userRef: DatabaseReference?, completion: @escaping ([Article]) -> Void){
        userRef?.observe(.value, with: { (snapshot) in
            
            var articlesToReturn = [Article]()
            
            for item in snapshot.children {
                let converter = ArticleConverter()
                let article = converter.convertSnapshotToArticle(snapshot: item as! DataSnapshot)
                articlesToReturn.append(article)
            }
            completion(articlesToReturn)
        })
    }
    
    
    /// Get Star Article on Branch
    
    
}
