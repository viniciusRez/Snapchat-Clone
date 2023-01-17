//
//  RegisterViewController.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 13/01/23.
//

import UIKit

class RegisterViewController: UIViewController {
    var registerViewModel: RegisterViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerViewModel = RegisterViewModel()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBOutlet weak var email: UITextField!
    
     @IBOutlet weak var nome: UITextField!

    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var confirmarSenha: UITextField!
    @IBAction func btnRegister(_ sender: Any) {
       self.registerViewModel.newUser(email: self.email.text!, nome: self.nome.text!, senha: self.senha.text!, confirmarSenha:self.confirmarSenha.text!,controller: self, completion: {alert in
            self.present(alert, animated: true)

        })
       
    }
}
