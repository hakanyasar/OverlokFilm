//
//  ViewController.swift
//  OverlokFilm
//
//  Created by hyasar on 11.09.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                
                if error != nil{
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }else{
                    // if email and password are true
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
            
        }else{
            // we are showing alert to user if email or password is void
            makeAlert(titleInput: "error", messageInput: "username/password?")
        }
        
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                
                if error != nil{
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }else{
                    
                    // if user creation was succeed
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
            
        }else{
            // we are showing alert to user if email or password is void
            makeAlert(titleInput: "error", messageInput: "username/password?")
           
        }
        
    }
    
    func makeAlert (titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

}

