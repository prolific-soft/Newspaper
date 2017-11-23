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
    
    /// The Stars Article branch of the Current USER
    
//    var REF_STARS = FirApi.User.REF_CURRENT_USER?.child("stars")
//    var user = UserApi().REF_CURRENT_USER?.child("stars")
    
    var REF_STARS = UserApi().REF_CURRENT_USER?.child("stars")

    
    /// Observe branch and returns a star
    
    
    /// Get Star Article on Branch
    
    
}
