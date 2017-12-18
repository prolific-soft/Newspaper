//
//  Source.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation

//Image size of URL's
struct urlsToLogos: Codable {
    //Properties
    var small: String
    var medium: String
    var large: String
}

//A source of an article as defined
//in the NEWS API
class Source: Codable {
    //Properties
    var id: String
    var name: String
    var description: String
    var url: String
    var category: String
    var language: String
    var urlsToLogos: urlsToLogos
    var sortBysAvailable: [String]
    
}

