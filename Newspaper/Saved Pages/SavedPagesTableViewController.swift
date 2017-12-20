//
//  SavedPagesTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/2/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD


class SavedPagesTableViewController: UITableViewController {
    
    ///MARK: Class Properties
    var article : Article? {
        didSet {
            print("+++++++++++++++++++")
            print("Article was set")
            print("+++++++++++++++++++")
            self.urlString = article?.url
        }
    }
    var articles = [Article]()
    var urlString : String?
    var savedPagesReference : DatabaseReference?
    var articleRef : DatabaseReference?
    var articlesByRef = [DatabaseReference : Article]()
    var handleAuthStateDidChange: AuthStateDidChangeListenerHandle?
    var observer : NSObjectProtocol?
    
    //The user currently logged in
    var currentUSER : User? {
        didSet {
            self.loadData()
        }
    }
    
    //First Loading Func
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        checkUserLoggedIn()
    }

    /// Checks for current logged user
    func checkUserLoggedIn() {
        handleAuthStateDidChange = Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.currentUSER = user
            }
        }
    }
    
    
    func loadFakeArticles(){
        let service = NewsAPIServices()
        service.getArticles(source: "cnn", sortBy: "top") { (result) in
            guard let list = result as? Articles else {return}
            DispatchQueue.main.async {
                self.articles = list.articles
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addArticleTapped(_ sender: UIBarButtonItem) {
        //guard let urlString = self.urlString else {return}
        
        let alert = UIAlertController(title: "Save web page",
                                      message: " Paste here the URL of the web page you want to save: ",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in

                                        //Get url from text using notification
                                       
                                        _ = alert.textFields![0] as UITextField

                                        
                                        SVProgressHUD.setDefaultMaskType(.black)
                                        SVProgressHUD.setMinimumSize(CGSize(width: 60, height: 100))
                                        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
                                        SVProgressHUD.showSuccess(withStatus: "Added to Saved Pages")

                                        guard let savedArticle = self.article else { return }
                                        self.addArticleToFirebase(withArticle: savedArticle)
                                        
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addTextField { (textfield) in
            textfield.text = self.urlString ?? ""
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)

        present(alert, animated: true, completion: nil)
    }

}//End Class


/// MARK: Add Article to Firebase Branch
extension SavedPagesTableViewController {
    
    func addArticleToFirebase(withArticle : Article) {
        
        /// Gets current user for star ref
        guard let user = currentUSER else {return}
        let savedPagesRef = UserApi.REF_USERS.child(user.uid).child(FirebaseBranchName.savedPages.rawValue)
        
        let savedArticleIdKey = savedPagesRef.childByAutoId().key
        let savedArticleRef = savedPagesRef.child(savedArticleIdKey)
        let convertedArticle = ArticleConverter().convertToAny(article: withArticle)
        savedArticleRef.setValue(convertedArticle)
        self.tableView.reloadData()
    }
}



/// MARK: Cells upon Appearing
extension SavedPagesTableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let handleAuthStateDidChange = handleAuthStateDidChange else { return }
        Auth.auth().removeStateDidChangeListener(handleAuthStateDidChange)
    }
}


/// MARK: Loading Data for Cells
extension SavedPagesTableViewController {
    
    func loadData(){
        guard let user = self.currentUSER else { return }
        let savedPagesReference = UserApi.REF_USERS.child(user.uid).child(FirebaseBranchName.savedPages.rawValue)
        
        savedPagesReference.observe(.value) { (snapshot) in
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
    }
}




//MARK: - Data Source
extension SavedPagesTableViewController {
    
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
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.savedSearchTableViewCell.rawValue, for: indexPath) as! SavedSearchTableViewCell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.savedSourceTableViewCell.rawValue, for: indexPath) as! SavedSourceTableViewCell
            cell.setUp(withArticle: articles[indexPath.row])
            return cell
        }
        return cell
    }
}




/// MARK: - Editing Cells
extension SavedPagesTableViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1 ? true : false
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




/// MARK: - Prepare for Segue
extension SavedPagesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: Segue.sourceOpenToArticleOpen.rawValue, sender: indexPath)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.sourceOpenToArticleOpen.rawValue {
            guard let indexPath = sender as? NSIndexPath else { return }
            
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as? SavedSourceTableViewCell
            if let articleOpenTableViewController = segue.destination as? ArticleOpenViewController {
                articleOpenTableViewController.article = cell?.article!
            }
        }
    }
    
    
}










