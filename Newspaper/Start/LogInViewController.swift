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

    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setDefaultMaskType(.black)
    }

    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let emailText = emailTextfield.text, let passwordText = passwordTextfield.text else {
            return
        }
        AuthService.signIn(email: emailText, password: passwordText, onSuccess: {
           SVProgressHUD.showSuccess(withStatus: "Success!")
            
        }) { (ErrorMessage) in
            SVProgressHUD.showError(withStatus: ErrorMessage!)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
