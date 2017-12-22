//
//  AllTagsTableViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/3/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class AllTagsTableViewCell: UITableViewCell {

    var articles : [Article]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(articles: [Article]){
        self.articles = articles
    }

}
