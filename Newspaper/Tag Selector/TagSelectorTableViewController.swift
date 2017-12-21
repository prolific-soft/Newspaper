//
//  TagSelectorTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 12/20/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SVProgressHUD

class TagSelectorTableViewController: UITableViewController {

    //MARK: - Class Properties
    var tags : [String] = []
    var tagText : String?
    var isSelected = false
    var article : Article?{
        didSet {
        }
    }
    
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
            self.loadData()
            print("User was set")
        }
    }
    
    //First Loading Func
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserLoggedIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadData()
        let index = IndexPath(row: self.tagArticlesByRef.count, section: 0)
        print(">>>> 1 >>>>>>")
        print(index)
        print(">>>>>>>>>>>")
        self.count = tagArticlesByRef.count
        print("Count : \(count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()

    }
    
    /// Checks for current logged user
    func checkUserLoggedIn() {
        handleAuthStateDidChange = Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.currentUSER = user
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let handleAuthStateDidChange = handleAuthStateDidChange else { return }
        Auth.auth().removeStateDidChangeListener(handleAuthStateDidChange)
    }
    
    //Dismisses the modal
    @IBAction func DoneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            //Finish up saving
            self.tableView.reloadData()
        }
    }
    
    //Creates Tags
    @IBAction func CreateTagTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Tag Name",
                                      message: "",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "OK",
                                       style: .default) { action in
                                        guard let textField = alert.textFields?.first,
                                            let text = textField.text else { return }
                                        
                                        self.tags.append(text)
                                        print("3")
                                        guard let taggedArticle = self.article else { return }
                                        self.addTagArticleToFirebase(withTag: text, article: taggedArticle)
                                        self.count = self.count + 1
                                        print("Count Increaded: \(self.count)")
                                        self.tableView.reloadData()
                                        
                                        //TODO: Fix so that it shows name of added tag

                                       
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
}


//MARK: - Saving Tags to Branch
extension TagSelectorTableViewController {
    func addTagArticleToFirebase(withTag: String, article : Article){
        guard let user = self.currentUSER else { return }
        let tagsReference = UserApi.REF_USERS.child(user.uid).child(FirebaseBranchName.tags.rawValue)
        let tagNameRef = tagsReference.child(withTag)
        let tagArticleID = tagNameRef.childByAutoId().key
        let tagArticleRef = tagNameRef.child(tagArticleID)
        let convertedArticle = ArticleConverter().convertToAny(article: article)
        tagArticleRef.setValue(convertedArticle)
    }
}



//MARK: - Loading Data
extension TagSelectorTableViewController {
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
                        }
                    }
                })

            }//eND FOR KEYS
            
        }//End tagsReference.observe
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }//End loadData
}




//MARK: - Data Source
extension TagSelectorTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tags.count tagArticlesByRef.keys.count
        return count
    }
}


//MARK: - Cell for Row
extension TagSelectorTableViewController {
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tagSelectorTableViewCell.rawValue, for: indexPath) as! TagSelectorTableViewCell
     
        var name = ""
        let tagKeys = Array(tagArticlesByRef.keys)
        name = tagKeys[indexPath.row].key
        cell.setUp(name: name)
        //cell.setUp(name: tags[indexPath.row] )
        
     return cell
        
    }
}


//MARK: Select and Deselect Cells check mark
extension TagSelectorTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
    }
}





