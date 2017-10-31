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
        sourceImageView.image = UIImage() // Clears Image memory so no repeats
        
        
        sourceTitle.text = withSource.name
        sourceDescription.text = withSource.description
        
        for item in list {
            if(withSource.id == item.key){
                sourceImageView.image = item.image
            }
        }
        
        //Circlar Image
        sourceImageView.layer.borderWidth = 0.25
        sourceImageView.layer.masksToBounds = false
        sourceImageView.layer.borderColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5).cgColor
        sourceImageView.layer.cornerRadius = sourceImageView.frame.height/2
        sourceImageView.clipsToBounds = true
 
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
