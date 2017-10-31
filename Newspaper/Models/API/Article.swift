//
//  Article.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation

//A single article as defined in
//the NEWS API

class Article: Codable {
    //Properties
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String?
    
    
}
