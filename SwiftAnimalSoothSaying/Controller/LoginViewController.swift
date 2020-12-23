//
//  LoginViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/11/30.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 10
        
    }
    

    @IBAction func login(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                
                print(error as Any)
                
            }else{
                
                self.performSegue(withIdentifier: "animal", sender: nil)
                
            }
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        
        
    }
    

}
