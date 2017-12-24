//
//  LogInViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/24/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import SVProgressHUD

class LogInViewController: UIViewController {
    @IBOutlet weak var backScrollView: UIScrollView!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.toolbar.isHidden = true
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let emailText = emailTextfield.text, let passwordText = passwordTextfield.text else {
            return
        }
        AuthService.signIn(email: emailText, password: passwordText, onSuccess: {
           //SVProgressHUD.showSuccess(withStatus: "Success!")
            self.performSegue(withIdentifier: Segue.loginToTabbar.rawValue, sender: nil)
        }) { (ErrorMessage) in
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.showError(withStatus: ErrorMessage!)
        }
    }

}


//MARK: - Textfield Animation
extension LogInViewController {
    
}





