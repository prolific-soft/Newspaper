//
//  SavedSourceTableViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/2/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class SavedSourceTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var sourceTitleLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var sourceDateLabel: UILabel!
    
    var article : Article?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(withArticle: Article) {
        //Set Selected Article
        self.article = withArticle
        sourceTitleLabel.text = withArticle.title
        sourceNameLabel.text = withArticle.author
        sourceImageView.image = UIImage()
        
        sourceImageView.layer.borderWidth = 0.25
        sourceImageView.layer.masksToBounds = false
        sourceImageView.layer.borderColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5).cgColor
        sourceImageView.layer.cornerRadius = 7
        sourceImageView.clipsToBounds = true
        
        //Format Time to Hours Ago before setting
        //sourceTimeLabel.text = withArticle.publishedAt
        let tempImageView = UIImageView()
        let url = URL(string: withArticle.urlToImage!)
        tempImageView.downloadImageFromUrl(url: url!) { (image) in
            if let data = image {
                self.sourceImageView.image = data
            }
        }
    }

}
