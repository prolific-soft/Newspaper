//
//  SourceOpenTableViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/30/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class SourceOpenTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var sourceTitleLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var sourceTimeLabel: UILabel!
    
    var article : Article?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //Sets up the views
    func setUp(withArticle: Article){
        //Set Selected Article
        self.article = withArticle
        sourceTitleLabel.text = withArticle.title
 
    }
    
    

}
