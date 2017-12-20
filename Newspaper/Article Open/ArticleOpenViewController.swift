//
//  ArticleOpenViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/1/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseDatabase
import FirebaseAuth
import SVProgressHUD
import Foundation


protocol ArticleSelectorDelegate: class {
    func articleSelector( article: Article?)
}

extension NSNotification.Name {
    static let SelectedArticle = NSNotification.Name("SelectedArticle")
}


class ArticleOpenViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    var article : Article?
    
    weak var articleDelegate : ArticleSelectorDelegate?
    
    var currentUSER : User?
    var handleAuthStateDidChange: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /// Refreshes the state of the current user so if
        /// another person signed in it will removes previous
        /// user and assign new user
        checkUserLoggedIn()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let handleAuthStateDidChange = handleAuthStateDidChange else { return }
        Auth.auth().removeStateDidChangeListener(handleAuthStateDidChange)
    }

    //Hide Tab bar
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    
    //Sets up view with article
    func setUp(){
        
        guard let title = self.article?.title, let author = self.article?.author, let published = self.article?.publishedAt,
            let description = self.article?.description  else {return}
        self.titleLabel.text = title
        self.authorLabel.text = author
        self.sourceTimeLabel.text = published
        self.descriptionLabel.text = description
        
        articleImage.layer.borderWidth = 0.25
        articleImage.layer.masksToBounds = false
        articleImage.layer.borderColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5).cgColor
        articleImage.layer.cornerRadius = 2
        articleImage.clipsToBounds = true
        
        //Format Time to Hours Ago before setting
        //sourceTimeLabel.text = withArticle.publishedAt
        let tempImageView = UIImageView()
        if let url = URL(string: (self.article?.urlToImage!)!) {
            tempImageView.downloadImageFromUrl(url: url) { (image) in
                if let data = image {
                    self.articleImage.image = data
                }
            }
        }
    }//End Setup
    
    
    //Opens Article in a new Safari View
    func openInSafariView(urlString : String) {
        let url = URL(string: urlString)!
        let controller = SFSafariViewController(url: url)
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func checkUserLoggedIn() {
       handleAuthStateDidChange = Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
               self.currentUSER = user
            }
        }
    }
    
    
    //Open Article to SafariViewController
    @IBAction func openButtonTapped(_ sender: Any) {
        if let urlString = self.article?.url {
            openInSafariView(urlString: urlString)
        }
    }
    
    //Saves the current Article to Star Articles
    @IBAction func starButtonTapped(_ sender: UIBarButtonItem) {
        
        /// Gets current user for star ref
        guard let user = currentUSER else {return}
        let starReference = UserApi.REF_USERS.child(user.uid).child(FirebaseBranchName.stars.rawValue)
        
        let newStarredArticleId = starReference.childByAutoId().key
        let newStarredArticleReference = starReference.child(newStarredArticleId)
        let convertedArticle = ArticleConverter().convertToAny(article: self.article!)
        newStarredArticleReference.setValue(convertedArticle)

        //TODO:
        // Disable button once it is saved and change the
        // icon to indicate star saving was successful
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumSize(CGSize(width: 50, height: 100))
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.showSuccess(withStatus: "Saved to Stars")
    }
    
    //Marks the article as read
    @IBAction func markReadButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    //Adds the current article to selected Tag
    @IBAction func taggedButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let selectedArticle = self.article else { return }
        NotificationCenter.default.post(name: NSNotification.Name.SelectedArticle , object: selectedArticle)
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumSize(CGSize(width: 50, height: 100))
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.showSuccess(withStatus: "Link Copied")
        
        //Use tab bar to access the SavedPages VC
        //so as to set it's article
        let tabBarVCS = self.tabBarController?.viewControllers
        let navBar = tabBarVCS![2] as? UINavigationController
        guard let savedPageVC = navBar?.viewControllers[0] as? SavedPagesTableViewController else {return}
        savedPageVC.article = self.article
        //print(savedPageVC.article)
    }
    
    //Opens options to share article
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {

        //Get TagOpenStoryBoard
        let storyboard = UIStoryboard(name: "Stars", bundle: nil)
        let tagSelectorNavVC = storyboard.instantiateViewController(withIdentifier: StoryboardID.tagSelectorNavVC.rawValue) as! UINavigationController
        let tagSelectorVC = tagSelectorNavVC.viewControllers[0] as! TagSelectorTableViewController
        tagSelectorVC.article = self.article
        self.present(tagSelectorNavVC, animated: true, completion: nil)
        
    }

    
}//End class ArticleOpenViewController








