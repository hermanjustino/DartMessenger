//
//  ViewController.swift
//  chatApp
//
//  Created by Herman Justino on 2021-05-14.
//
// App Icons by:
// <a target="_blank" href="undefined/icons/set/chat--v1">Chat icon</a> icon by <a target="_blank" href="">Icons8</a>

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    private func validateAuth(){
        
        if FirebaseAuth.Auth.auth().currentUser == nil{
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

