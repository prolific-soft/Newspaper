//
//  SubscriptionTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/2/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class SubscriptionTableViewController: UITableViewController {

    //class Properties
    var imageCategory = [String : UIImage]()
    var sourceCategories = [String : [Source]]()
    
    var sources = [Source]()

    
    var subscriptionReference : DatabaseReference?
    var sourceRef : DatabaseReference?
    var sourcesByRef = [DatabaseReference : Source]()
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
        self.checkUserLoggedIn()
    }


    //Remove Auth Listener
    override func viewDidDisappear(_ animated: Bool) {
        guard let handleAuthStateDidChange = handleAuthStateDidChange else { return }
        Auth.auth().removeStateDidChangeListener(handleAuthStateDidChange)
    }

    
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
            return sources.count
        default:
            return 1
        }
    }

    //Dequeue Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.subscriptionSearchTableViewCell.rawValue, for: indexPath) as! SubscriptionSearchTableViewCell
        }else if indexPath.section == 1  {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.allArticlesTableViewCell.rawValue, for: indexPath) as! AllArticlesTableViewCell
            
            cell.setUp(sources: self.sources)
            return cell
            
        }else if indexPath.section == 2  {
           let cell = tableView.dequeueReusableCell(withIdentifier: Cell.subsriptionSourcesTableViewCell.rawValue, for: indexPath) as! SubsriptionSourcesTableViewCell
            
            let source = sources[indexPath.row]
            cell.setUp(source: source)
            return cell
        }
        return cell
    }

    //Temporary Logout User
    //This will be implemented at the Slide Menu
    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }catch let logoutError {
            SVProgressHUD.showError(withStatus: logoutError.localizedDescription)
        }
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: StoryboardID.startNavigationController.rawValue) as! UINavigationController
        self.present(navController, animated: true, completion: nil)
    }
    
    // Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.exploreOpenToStars.rawValue {
            if let starsTableViewController = segue.destination as? StarsTableViewController {
            
                guard let indexPath = sender as? NSIndexPath else { return }
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as? ExploreOpenTableViewCell
                starsTableViewController.articles = (cell?.articles)!
            }
        }
        
        if segue.identifier == Segue.subscriptionToSourceOpen.rawValue {
            if let subcriptionSourceOpenTableViewController = segue.destination as? SubcriptionSourceOpenTableViewController {
                guard let indexPath = sender as? NSIndexPath else { return }
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as? SubsriptionSourcesTableViewCell
                subcriptionSourceOpenTableViewController.articles = (cell?.articles)!
            }
        }

        if segue.identifier == Segue.allArticlesToSourceOpen.rawValue {
            if let subcriptionSourceOpenTableViewController = segue.destination as? SubcriptionSourceOpenTableViewController {
                guard let indexPath = sender as? NSIndexPath else { return }
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as? AllArticlesTableViewCell
                subcriptionSourceOpenTableViewController.articles = (cell?.articles)!
            }
        }
        
        
    }
    
    
    /// Checks for current logged user
    func checkUserLoggedIn() {
        handleAuthStateDidChange = Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.currentUSER = user
            }
        }
    }
    
    func loadData(){
        guard let user = self.currentUSER else { return }
        let subscribedSourceRef = UserApi.REF_USERS.child(user.uid).child(FirebaseBranchName.subscriptions.rawValue)
        
        subscribedSourceRef.observe(.value) { (snapshot) in
            var sourcesToReturn = [Source]()
            
            for item in snapshot.children{
                let converter = SourceConverter()
                let source = converter.convertSnapshotToArticle(snapshot: item as! DataSnapshot)
                sourcesToReturn.append(source)
                
                //Get the ref of the item and store it as key for an
                //Source in the dicionary
                guard let itemRef = item as? DataSnapshot else { return }
                let sourceRef = itemRef.ref
                self.sourcesByRef[sourceRef] = source
            }
            
            DispatchQueue.main.async {
                self.sources = sourcesToReturn
                self.tableView.reloadData()
//                print("++++++++++++++++++++++++++++++++")
//                print("Number of Sources : \(self.sources.count)")
//                print("++++++++++++++++++++++++++++++++")
            }
        }
    }//End loadData()


}//End class SubscriptionTableViewController


extension SubscriptionTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            self.performSegue(withIdentifier: Segue.subscriptionToSourceOpen.rawValue, sender: indexPath)
        }
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: Segue.allArticlesToSourceOpen.rawValue, sender: indexPath)
        }
    }
}

/// MARK: - Editing Cells
extension SubscriptionTableViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //Only section 2 can be deleted
        return indexPath.section == 2 ? true : false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            let source = sources[indexPath.row]
            
            for (keyRef, value) in sourcesByRef {
                if value.name! == source.name!  {
                    keyRef.removeValue()
                    self.tableView.reloadData()
                }
            }
        }

    }//End Commit EditingStyle
}
