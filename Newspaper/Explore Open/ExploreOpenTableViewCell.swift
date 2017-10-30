//
//  ExploreOpenTableViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/27/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class ExploreOpenTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceImageView: UIImageView!
    
    @IBOutlet weak var sourceTitle: UILabel!
    
    @IBOutlet weak var sourceDescription: UILabel!
    
    @IBOutlet weak var subscriberCount: UILabel!
    
    @IBOutlet weak var articleCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp(withSource : Source){
        
        let list = SourceImages().getSourceImages()
        
        
        sourceTitle.text = withSource.name
        sourceDescription.text = withSource.description
        
        for item in list {
            if(withSource.id == item.key){
                sourceImageView.image = item.image
            }
            
            
        }
        
 
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
