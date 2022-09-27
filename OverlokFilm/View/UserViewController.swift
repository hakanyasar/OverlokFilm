//
//  UserViewController.swift
//  OverlokFilm
//
//  Created by hyasar on 11.09.2022.
//

import UIKit
import Firebase

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func logoutClicked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("error")
        }
        
    }
    
}
