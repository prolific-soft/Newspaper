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
        sourceNameLabel.text = withArticle.author
        
        
        //Format Time to Hours Ago before setting
        //sourceTimeLabel.text = withArticle.publishedAt
        
        downloadImage(article: withArticle)
 
    }
    
    func downloadImage(article: Article){
        
        sourceImageView.image = nil
        guard let urlLink = article.urlToImage else {return}
        guard let url = URL(string: urlLink) else {return}
        let imageDownloader = NetworkProcessor(url: url)
        
        imageDownloader.downloadImageDataFromURL { (imageData, response, error) in
            
            DispatchQueue.main.async {
                if let data = imageData {
                    self.sourceImageView.image = UIImage(data: data)
                    
                }
            }
        }
    }
    

}// End SourceOpenTableViewCell
