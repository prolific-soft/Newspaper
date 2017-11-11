//
//  SubcriptionSourceOpenTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/5/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class SubcriptionSourceOpenTableViewController: UITableViewController {

 
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //self.loadFakeArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // self.loadFakeArticles()
        self.clearsSelectionOnViewWillAppear = true
    }
    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return articles.count
        default:
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell = UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.starsSearchTableViewCell.rawValue, for: indexPath) as! StarsSearchTableViewCell
            
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.subscriptionSourceOpenTableViewCell.rawValue, for: indexPath) as! SubscriptionSourceOpenTableViewCell
            cell.setUp(withArticle: articles[indexPath.row])
            return  cell
        }
        return  cell
    }
    
    
    func loadFakeArticles(){
        let service = NewsAPIServices()
        service.getArticles(source: "bbc-news", sortBy: "top") { (result) in
            guard let list = result as? Articles else {return}
            DispatchQueue.main.async {
                self.articles = list.articles
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    


     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.subStartoArticleOpen.rawValue {
            
            guard let indexPath = sender as? NSIndexPath else { return }
            
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as? SubscriptionSourceOpenTableViewCell


            if let articleOpenTableViewController = segue.destination as? ArticleOpenViewController {
                articleOpenTableViewController.article = cell?.article!

            }
        }
        
     }// End prepare for Segue
 

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segue.subStartoArticleOpen.rawValue, sender: indexPath)
    }
    
    
    
    
    
    
}//End class SubcriptionSourceOpenTableViewController
