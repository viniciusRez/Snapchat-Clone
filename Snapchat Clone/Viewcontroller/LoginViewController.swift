//
//  LoginViewController.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 13/01/23.
//

import UIKit

class LoginViewController: UIViewController {
    var loginViewMode:LoginViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginViewMode = LoginViewModel()


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var senha: UITextField!
    @IBAction func btnLogin(_ sender: Any) {
        self.loginViewMode.login(email: self.email.text!, senha: self.senha.text!,controller: self ,completion: {alert in
            self.present(alert, animated: true)

        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
