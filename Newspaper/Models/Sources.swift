//
//  Sources.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation

//Contains a list of sources
//from the API
struct Sources: Codable {
    let status : String
    let sources : [Source]
}
