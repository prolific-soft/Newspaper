//
//  StarsTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/2/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class StarsTableViewController: UITableViewController {

    var articles = [Article]()
    var starReference : DatabaseReference?
    var handleAuthStateDidChange: AuthStateDidChangeListenerHandle?
    
    var currentUSER : User? {
        didSet {
            self.loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

         self.checkUserLoggedIn()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Uncomment the following line to preserve selection between presentations
        //self.loadData()
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        guard let handleAuthStateDidChange = handleAuthStateDidChange else { return }
        Auth.auth().removeStateDidChangeListener(handleAuthStateDidChange)
    }
    
    /// Checks for current logged user
    func checkUserLoggedIn() {
        handleAuthStateDidChange = Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.currentUSER = user
            }
        }
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
           let cell = tableView.dequeueReusableCell(withIdentifier: Cell.starsTableViewCell.rawValue, for: indexPath) as! StarsTableViewCell
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
    
    func loadData(){
        guard let user = self.currentUSER else { return }
        let starReference = UserApi.REF_USERS.child(user.uid).child("stars")
        
        starReference.observe(.value) { (snapshot) in
            //
            var articlesToReturn = [Article]()
            
            for item in snapshot.children {
                let converter = ArticleConverter()
                let article = converter.convertSnapshotToArticle(snapshot: item as! DataSnapshot)
                articlesToReturn.append(article)
            }
            
            DispatchQueue.main.async {
                self.articles = articlesToReturn
                self.tableView.reloadData()
                print(self.articles)
            }
        }

    }//End loadData()


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}


/// MARK: - Navigation
extension StarsTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.startoArticleOpen.rawValue {
            
            guard let indexPath = sender as? NSIndexPath else { return }
            
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as? StarsTableViewCell
            
            if let articleOpenTableViewController = segue.destination as? ArticleOpenViewController {
                articleOpenTableViewController.article = cell?.article!
            }
        }
    }// End prepare for Segue
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segue.startoArticleOpen.rawValue, sender: indexPath)
    }
    
}
