//
//  ProfileViewController.swift
//  chatApp
//
//  Created by Herman Justino on 2021-05-14.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let data = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell .self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath )
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "",
                                            message: "Are you sure you want to log out of your account?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out",
                                            style: .destructive,
                                            handler: { [weak self] _ in
                                                
                                                guard let strongSelf = self else {
                                                    return
                                                }
                                                
                                                //Log out of FaceBook
                                                FBSDKLoginKit.LoginManager().logOut()
                                                
                                                //Google Sign Out
                                                GIDSignIn.sharedInstance()?.signOut()
                                                
                                                do {
                                                    try FirebaseAuth.Auth.auth().signOut()
                                                    let vc = LoginViewController()
                                                    let nav = UINavigationController(rootViewController: vc)
                                                    nav.modalPresentationStyle = .fullScreen
                                                    strongSelf.present(nav, animated: false)
                                                } catch  {
                                                    print("Failed to Signout")
                                                }
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel ,
                                            handler: nil))
        present(actionSheet, animated: true)
    }
}
