//
//  SuccessfullViewController.swift
//  ExFirebase
//
//  Created by RLogixxTraining on 01/03/24.
//

import UIKit
import FirebaseFirestore
import Firebase

class SuccessfullViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tblView: UITableView!
    
    let database = Firestore.firestore()
        var dataArray: [[String: Any]] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tblView.delegate = self
            tblView.dataSource = self
            
            fetchData()
        }
        
        func fetchData() {
            guard let currentUser = Auth.auth().currentUser else {
                print("No user is currently signed in")
                return
            }
            let docRef = database.collection("users").document(currentUser.uid)
            docRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    print("Error fetching data: \(String(describing: error))")
                    return
                }
                
                self.dataArray.append(data)
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
        }
        
        // MARK: - UITableViewDataSource Methods
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
            let identifier = "cell"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AllDataTableviewCell
            if cell == nil {
                tableView.register(UINib(nibName: "AllDataTableviewCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AllDataTableviewCell
            }
            let data = dataArray[indexPath.row]
            let email = data["email"] as? String ?? "No Email"
            let password = data["password"] as? String ?? "No Password"
            let phone = data["phone"] as? String ?? "No Phone"
            
            cell?.txtEmail.text = email
            cell?.txtPassword.text = password
            cell?.txtPhone.text = phone
            
//            cell?.textLabel?.text = "Email: \(email)\nPassword: \(password)\nPhone: \(phone)"
//            cell?.textLabel?.numberOfLines = 0
            
            return cell!
        }
    }
