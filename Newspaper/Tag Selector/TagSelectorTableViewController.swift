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
    var articles = [Article]()
    var starReference : DatabaseReference?
    var articleRef : DatabaseReference?
    var articlesByRef = [DatabaseReference : Article]()
    var handleAuthStateDidChange: AuthStateDidChangeListenerHandle?
    
    //The user currently logged in
    var currentUSER : User? {
        didSet {
           // self.loadData()
            print("User was set")
        }
    }
    
    //First Loading Func
    override func viewDidLoad() {
        super.viewDidLoad()
        //tags = ["Duff", "Phlegm", "Put"]
        checkUserLoggedIn()
//        print("+++++++++++++++++++")
//        print("Article was set")
//        print("Article \(self.article?.author)")
//        print("Article \(self.article?.description)")
//        print("+++++++++++++++++++")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
                                            let text = textField.text else { return } //CHECK TO MAKE SURE NOT EMPTY
                                        
                                        self.tags.append(text)
                                        print("3")
                                        guard let taggedArticle = self.article else { return }
                                        self.addTagArticleToFirebase(withTag: text, article: taggedArticle)
                                        self.tableView.reloadData()
                                        print("2")
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



//MARK: - Data Source
extension TagSelectorTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
}


//MARK: - Cell for Row
extension TagSelectorTableViewController {
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tagSelectorTableViewCell.rawValue, for: indexPath) as! TagSelectorTableViewCell
     
        cell.setUp(name: tags[indexPath.row] )
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





