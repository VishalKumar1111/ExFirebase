//
//  SignUpController.swift
//  ExFirebase
//
//  Created by RLogixxTraining on 01/03/24.
//

import UIKit
import FirebaseAuth

class SignUpController: UIViewController {

  
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        if txtEmail.text?.isEmpty == true{
            print("No Text in Email Field")
            return
        }
        if txtPassword.text?.isEmpty == true {
            print("No Text in PassWord Field")
            return
        }
        signUp()
    }
    
    @IBAction func btnAlready(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login" ) as? ViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (authResult, error) in
            if let error = error {
                print("Error signing up: \(error.localizedDescription)")
                return
            }
            
            // User successfully signed up
            print("User signed up successfully!")
            // You can perform additional actions here if needed, such as navigating to the next screen
        }
    }
    
}
