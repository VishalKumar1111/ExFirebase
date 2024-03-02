import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController{
    @IBOutlet weak var btngoogle:GIDSignInButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }

    @IBAction func btnLogin(_ sender: Any) {
        validateFields()
    }
    
    func validateFields() {
        guard let email = txtEmail.text, !email.isEmpty else {
            print("Email field is empty")
            return
        }
        guard let password = txtPassword.text, !password.isEmpty else {
            print("Password field is empty")
            return
        }
        login(withEmail: email, password: password)
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                print("Login error: \(error.localizedDescription)")
            } else {
                self.checkUserInfo()
                
            }
        }
    }
    
    func checkUserInfo() {
        if let currentUser = Auth.auth().currentUser {
            print("User ID: \(currentUser.uid)")
            // Navigate to the home screen or perform any other action
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "home" ) as? SuccessfullViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        } else {
            print("No user is currently signed in")
        }
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
       
        guard let clientID = FirebaseApp.app()?.options.clientID else {
                   return
               }

               // Create Google Sign In configuration object.
               let config = GIDConfiguration(clientID: clientID)
               GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard error == nil else{
                print("Google sign-in error: \(error?.localizedDescription ?? "Error GoogleLogin")")
                return
            }
            guard let authentication = result?.user, let idToken = authentication.idToken?.tokenString  else {
                print("Google authentication error")
                return
          }


            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken.tokenString)

                   Auth.auth().signIn(with: credential) { authResult, error in
                       if let error = error {
                           print("Firebase authentication error: \(error.localizedDescription)")
                           return
                       }
                       // Firebase authentication successful, you can navigate to the next screen or perform any other action
                       
                       self?.checkUserInfo()
                       
                       
                   }
               }
           }
        }
        
     



