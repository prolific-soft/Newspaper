//
//  Segue.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/31/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation


enum Segue : String {
    
    //Explore Open
    case toExploreOpen = "toExploreOpen"
    case toSourceOpen = "toSourceOpen"
    // To TabBar Controller
    case loginToTabbar = "loginToTabbar"
    case signUpToTabbar = "signUpToTabbar"
    //Subscription
    case subscriptionToSourceOpen = "subscriptionToSourceOpen"
    case exploreOpenToStars = "exploreOpenToStars"
    case subStartoArticleOpen = "subStartoArticleOpen"
    case allArticlesToSourceOpen = "allArticlesToSourceOpen"
    case sourceOpenToArticleOpen = "sourceOpenToArticleOpen"
    //Star
    case startoArticleOpen = "startoArticleOpen"
    //Article Open
    case articleOpenToTagSelectorTVC = "articleOpenToTagSelectorTVC"
    case toTagVC = "toTagVC"
    
}
