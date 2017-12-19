//
//  SubcriptionSourceOpenTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/5/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SVProgressHUD

class SubcriptionSourceOpenTableViewController: UITableViewController {

    var articles = [Article]()
    var source : Source?
    
    var currentUSER : User?
    var handleAuthStateDidChange: AuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.clearsSelectionOnViewWillAppear = true
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = true
        checkUserLoggedIn()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let handleAuthStateDidChange = handleAuthStateDidChange else { return }
        Auth.auth().removeStateDidChangeListener(handleAuthStateDidChange)
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
    
    //Subscribes to a NewsSource and saved to the
    //Firebase Branch of the user
    @IBAction func saveNewsSource(_ sender: Any) {
        
        /// Gets current user for star ref
        guard let user = currentUSER else {return}
        let subscriptionReference = UserApi.REF_USERS.child(user.uid).child("subscriptions")
        let subscriptionId = subscriptionReference.childByAutoId().key
        let subscriptionIdReference = subscriptionReference.child(subscriptionId)
        let convertedSource = SourceConverter().convertToAny(source: self.source!)
        subscriptionIdReference.setValue(convertedSource)
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumSize(CGSize(width: 50, height: 100))
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.showSuccess(withStatus: "Subscribed!")
    }
    
    func checkUserLoggedIn() {
        handleAuthStateDidChange = Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.currentUSER = user
            }
        }
    }

    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    


     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.sourceOpenToArticleOpen.rawValue {
            guard let indexPath = sender as? NSIndexPath else { return }
            
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as? SubscriptionSourceOpenTableViewCell
            if let articleOpenTableViewController = segue.destination as? ArticleOpenViewController {
                articleOpenTableViewController.article = cell?.article!
            }
        }
     }// End prepare for Segue subStartoArticleOpen
 

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: Segue.sourceOpenToArticleOpen.rawValue, sender: indexPath)
        }
       
    }
    
    
    
}//End class SubcriptionSourceOpenTableViewController


