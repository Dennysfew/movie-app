//
//  SignInViewController.swift
//  Movie-app
//
//  Created by Denys on 11.07.2022.
//

import UIKit
import FirebaseAuth
class SignInViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.alpha = 0
        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func signInTapped(_ sender: Any) {
        
      
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                //Couldn't sign in
                self.label.text = error!.localizedDescription
                self.label.alpha = 1
            } else {
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
}
