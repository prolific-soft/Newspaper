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

    ///MARK: Class Properties
    var articles = [Article]()
    var starReference : DatabaseReference?
    var articleRef : DatabaseReference?
    var articlesByRef = [DatabaseReference : Article]()
    var handleAuthStateDidChange: AuthStateDidChangeListenerHandle?
    
    //The user currently logged in
    var currentUSER : User? {
        didSet {
            self.loadData()
        }
    }
    
    //First Loading Func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension

         self.checkUserLoggedIn()
        
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
    }//End checkUserLoggedIn()
}


/// MARK: Configuring Cells
extension StarsTableViewController {
    
    //Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //Number of Rows
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
    
    //Cell for Row
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
}


/// MARK: Loading Data for Cells
extension StarsTableViewController {
    
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
        let starReference = UserApi.REF_USERS.child(user.uid).child(FirebaseBranchName.stars.rawValue)
        
        starReference.observe(.value) { (snapshot) in
            var articlesToReturn = [Article]()
            
            for item in snapshot.children {
                let converter = ArticleConverter()
                let article = converter.convertSnapshotToArticle(snapshot: item as! DataSnapshot)
                articlesToReturn.append(article)
                
                //Get the ref of the item and store it as key for an
                //article in the dicionary
                guard let itemRef = item as? DataSnapshot else { return }
                let articleRef = itemRef.ref
                self.articlesByRef[articleRef] = article
            }
            
            DispatchQueue.main.async {
                self.articles = articlesToReturn
                self.tableView.reloadData()
            }
        }
        
    }//End loadData()
}


/// MARK: - Editing Cells
extension StarsTableViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let article = articles[indexPath.row]
            
            for (keyRef, value) in articlesByRef {
                if value.title == article.title  {
                    keyRef.removeValue()
                    self.tableView.reloadData()
                }
            }
        }
    }//End Commit EditingStyle
}


/// MARK: - Navigation & Segue
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




