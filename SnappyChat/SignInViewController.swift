//
//  SignInViewController.swift
//  SnappyChat
//
//  Created by Thomas Carlson on 14/5/18.
//  Copyright © 2018 SurfMachina. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailtextfield: UITextField!
    
    @IBOutlet weak var passwordtextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signintapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailtextfield.text!, password: passwordtextfield.text!, completion: {(user,error) in
            print ("We tried to sign in")
            if error != nil {
                print("hey, we have an error \(error ?? "unknown" as! Error)")
                
                Auth.auth().createUser(withEmail: self.emailtextfield.text!, password: self.passwordtextfield.text!, completion: {(user,error) in
                    print ("We tried to create a user")
                    
                    if error != nil {
                        print("hey, we have an error \(error ?? "unknown" as! Error)")
                    } else {
                        print("created user successfully")
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                    
                })
                
            } else {
                print("success")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
                
            }
            
        })
        
        
    }
    
}

