//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Samuel Carbone on 1/29/18.
//  Copyright © 2018 Samuel Carbone. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUp(_ sender: Any) {
        let newUser = PFUser()
        
        // set user properties
        newUser.username = username.text ?? ""
        newUser.password = password.text ?? ""
        if username.text!.isEmpty || password.text!.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Username or password is empty.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                //Do nothing
            }
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
                return;
            }
        }
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    //Do nothing
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    return;
                }
            } else {
                print("User Registered successfully")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }
    @IBAction func logIn(_ sender: Any) {
        let username = self.username.text ?? ""
        let password = self.password.text ?? ""
        if username.isEmpty || password.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Username or password is empty.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                //Do nothing
            }
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
                return;
            }
        }
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    //Do nothing
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    return;
                }
            } else {
                print("User logged in successfully")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }

}
