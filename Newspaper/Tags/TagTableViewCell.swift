//
//  TagTableViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/3/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {

    @IBOutlet weak var tagName: UILabel!
    
    var articles : [Article]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(name : String, articles : [Article]){
        self.tagName.text = name
        self.articles = articles
    }
    

}
