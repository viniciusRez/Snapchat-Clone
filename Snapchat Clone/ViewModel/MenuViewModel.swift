//
//  MenuViewModel.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 16/01/23.
//

import Foundation
import UIKit
import FirebaseAuth
class menuViewModel {

    var controller:UIViewController
    init(controller: UIViewController) {
        self.controller = controller
    }
    func checkLogin() {
        let login = Auth.auth()
        login.addStateDidChangeListener { (Auth, usuario) in
            if usuario != nil{
                self.router( identifier: "isLogged")
            }
        }
         
    }
    func router(identifier:String ) {
        self.controller.performSegue(withIdentifier: identifier, sender: nil)
        
    }
}
