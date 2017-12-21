//
//  TagSelectorTableViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 12/20/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class TagSelectorTableViewCell: UITableViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func setUp(name: String){
        var cachename = ""
        cachename = name
        tagLabel.text = cachename
    }
    
    
}
