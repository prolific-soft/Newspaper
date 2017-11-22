//
//  FirApi.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation

/// Singleton to hold the different branches or nodes
/// on the Firebase database

struct FirApi {
    
    static var User = UserApi()
    static var Subscription = SubscriptionApi()
    static var Stars = StarsApi()
    static var SavedPages = SavedPagesApi()
    static var Tags = TagsApi()
    
}
