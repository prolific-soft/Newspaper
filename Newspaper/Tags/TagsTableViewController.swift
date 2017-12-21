//
//  TagsTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/2/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SVProgressHUD

class TagsTableViewController: UITableViewController {

    // Class Properties
    var count = 0
    var articles = [Article]()
    var starReference : DatabaseReference?
    var articleRef : DatabaseReference?
    var articlesByRef = [DatabaseReference : Article]()
    var tagArticlesByRef = [DatabaseReference : [Article]]()
    var handleAuthStateDidChange: AuthStateDidChangeListenerHandle?
    
    //The user currently logged in
    var currentUSER : User? {
        didSet {
            print("User was set")
            self.loadData()
        }
    }
    
    //First loading func
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserLoggedIn()
        self.clearsSelectionOnViewWillAppear = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //self.loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let handleAuthStateDidChange = handleAuthStateDidChange else { return }
        Auth.auth().removeStateDidChangeListener(handleAuthStateDidChange)
    }

}


// MARK: - Data Source
extension TagsTableViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return tagArticlesByRef.count
        default:
            return 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.tagSearchTableViewCell.rawValue, for: indexPath) as! TagSearchTableViewCell
        }else if indexPath.section == 1  {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.allTagsTableViewCell.rawValue, for: indexPath) as! AllTagsTableViewCell
            //load Articles for AllTags
            for (_, v) in articlesByRef {
                self.articles.append(v)
            }
            cell.setUp(articles: self.articles)
            return cell
        }else if indexPath.section == 2  {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tagTableViewCell.rawValue, for: indexPath) as! TagTableViewCell
            
            let tagKeys = Array(tagArticlesByRef.keys)
            let nameRef = tagKeys[indexPath.row]
            
            cell.setUp(name: nameRef.key, articles: tagArticlesByRef[nameRef]!)
            return cell
        }
        return cell
    }
}


//MARK: - Load Current User
extension TagsTableViewController {
    
    /// Checks for current logged user
    func checkUserLoggedIn() {
        handleAuthStateDidChange = Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.currentUSER = user
            }
        }
    }
    
    //Loads data from Firebase
    func loadData() {
        
        //Get the tag for current user
        guard let user = self.currentUSER else { return }
        let tagsReference = UserApi.REF_USERS.child(user.uid).child(FirebaseBranchName.tags.rawValue)
        
        //Find the tag keys
        tagsReference.observe(DataEventType.value) { (snapshot) in
            guard let tagDict = snapshot.value as? [String : AnyObject] else {return}
            let keys = Array(tagDict.keys)
            
            //Take each tags keys and finds the articles for that tag
            for key in keys {
                let keyReference = tagsReference.child(key)
                keyReference.observe(.value, with: { (snap) in
                    var articlesToReturn = [Article]()
                    
                    //The articles for tag keys
                    for item in snap.children {
                        let converter = ArticleConverter()
                        let article = converter.convertSnapshotToArticle(snapshot: item as! DataSnapshot)
                        articlesToReturn.append(article)
                        
                        guard let itemRef = item as? DataSnapshot else { return }
                        let articleRef = itemRef.ref
                        
                        //Add the articles to article ref and the key ref to tagArticleByRefs
                        DispatchQueue.main.async {
                            self.articlesByRef[articleRef] = article
                            self.tagArticlesByRef[keyReference] = articlesToReturn
                            self.tableView.reloadData()
                        }
                    }
                })
            }//eND FOR KEYS
        }//End tagsReference.observe
    }//End loadData
    
}


//MARK: Segue
extension TagsTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            self.performSegue(withIdentifier: Segue.tagTableViewCellToSSOCTVC.rawValue, sender: indexPath)
        }
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: Segue.allTagTableViewCellToSSOTVC.rawValue, sender: indexPath)
        }
    }
    
    // Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == Segue.allTagTableViewCellToSSOTVC.rawValue {
            if let subcriptionSourceOpenTableViewController = segue.destination as? SubcriptionSourceOpenTableViewController {
                guard let indexPath = sender as? NSIndexPath else { return }
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as? AllTagsTableViewCell
                
                subcriptionSourceOpenTableViewController.navigationItem.title = "All Tags"
                subcriptionSourceOpenTableViewController.articles = (cell?.articles)!
            }
        }
        
        if segue.identifier == Segue.tagTableViewCellToSSOCTVC.rawValue {
            if let subcriptionSourceOpenTableViewController = segue.destination as? SubcriptionSourceOpenTableViewController {
                guard let indexPath = sender as? NSIndexPath else { return }
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as? TagTableViewCell
                
                let tagKeys = Array(tagArticlesByRef.keys)
                let nameRef = tagKeys[indexPath.row]
                let tagName = nameRef.key
                subcriptionSourceOpenTableViewController.navigationItem.title = tagName
                subcriptionSourceOpenTableViewController.articles = (cell?.articles)!
            }
        }
        
    }
    
}





