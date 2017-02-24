//
//  ViewController.swift
//  TeamChat
//
//  Created by daniel on 2/2/17.
//  Copyright © 2017 Notabela. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController
{
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        userNameField.underlined(with: UIColor.white)
        passwordField.underlined(with: UIColor.white)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onLogin(_ sender: Any)
    {
        guard let username = userNameField.text else {
            displayErrorAlert(title: "Username Required", message: "Please enter your username")
            return
        }
        
        guard let password = passwordField.text else {
            displayErrorAlert(title: "Password Required", message: "Please enter your password")
            return
        }

            PFUser.logInWithUsername(inBackground: username, password: password, block: { (user: PFUser?, error: Error?) in
                
                print("logged In")
                self.performSegue(withIdentifier: "chatViewSegue", sender: user)
            })
    }
    
    @IBAction func onSignUp(_ sender: Any)
    {
        
        guard let username = userNameField.text else {
            displayErrorAlert(title: "Username Required", message: "Please enter your username")
            return
        }
        
        guard let password = passwordField.text else {
            displayErrorAlert(title: "Password Required", message: "Please enter your password")
            return
        }
        
        let user = PFUser()
        user.username = username
        user.password = password
        
        user.signUpInBackground
        {
            (succeeded: Bool, error: Error?) in
            
            if let error = error?.localizedDescription
            {
                self.displayErrorAlert(title: "Error", message: error)
                
            } else {
                
                print("successss")
                self.performSegue(withIdentifier: "chatViewSegue", sender: user)
            }
        }
    }
    
    func displayErrorAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

}

