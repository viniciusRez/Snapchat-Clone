//
//  ViewController.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: menuViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = menuViewModel(controller: self)
        self.viewModel.checkLogin()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func btnLogin(_ sender: Any) {
        self.viewModel.router(identifier: "login")
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        self.viewModel.router(identifier: "register")

    }
}

