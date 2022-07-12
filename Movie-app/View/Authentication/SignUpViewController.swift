//
//  SignUpViewController.swift
//  Movie-app
//
//  Created by Denys on 09.07.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmedPasswordTextField: UITextField!
 
    @IBOutlet var errorLabel: UILabel!
    //var model: ModelData
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    // MARK: - valideteFields
    // Check the fields and validate that the data is correct. If everything ok this methods returns nil. Otherwise it returns the error message
    func validateFields() -> String? {
        
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmedPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        // check if the email is right
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if  Utilities.isValidEmail(cleanedEmail) == false {
            //the email isn't right
            return "Please make sure your email is right  "
        }
        // check if the password is secure
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if  Utilities.isPasswordValid(cleanedPassword) == false {
            //the password isn't secure enough
            return "Please make sure your password is at least 8 charecters, contains a special character and a numbe r  "
        }
        
        // check if the password is the same as confirmed
        if passwordTextField.text != confirmedPasswordTextField.text {
            return "Check the password conformation"
        }
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            //The is something wrong with the fields, show error massege
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
          
            
            
            
            // create the user
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil {
                    // there was an error creating the user
                    self.showError("Error creating user")
                } else {
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["first_name" : firstName, "last_name" : lastName, "uid" : result!.user.uid]) { (error) in
                        
                        if error != nil {
                            //show error message
                            self.showError("error saving user data")
                        }
                    }
                    // Transiotion to home screen
                    self.transitionToHome()
                    
                    
                }
            }
           
            
        }
    
    }
    
    
    
    // MARK: - show Error
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}


 

