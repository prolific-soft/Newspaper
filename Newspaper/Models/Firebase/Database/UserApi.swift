//
//  UserApi.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

/// The current user or users on
/// the database branch

class UserApi {
    
    /// Users branch on database node
    var REF_USERS = Database.database().reference().child("users")
    
    /// Gets the current user or nil
    var CURRENT_USER: User? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        return nil
    }
    
    
    
    /// The current User Branch
    var REF_CURRENT_USER: DatabaseReference? {
        Auth.auth().addStateDidChangeListener { (Auth, User) in
            //
        }
        
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }
        return REF_USERS.child(currentUser.uid)
    }

    
    
    
    
    
}// End class UserApi
