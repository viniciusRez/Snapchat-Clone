//
//  RegisterViewModel.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 13/01/23.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase


class RegisterViewModel{
  

    func newUser(email:String,nome:String,senha:String,confirmarSenha:String,controller:UIViewController ,completion:@escaping(UIAlertController) ->Void){
        if email != "" && senha !=  "" && confirmarSenha !=  "" && nome !=  "" {
            if self.checkPassword(senha: senha, confirmarSenha: confirmarSenha) {
                self.register(email: email, senha: senha,nome: nome,completion: {result,alert in
                    if result{
                        completion(alert.makeAlert(segue: nil,controller:controller,sender: nil))

                    }else{
                            completion( alert.makeAlert(segue: "registerInside",controller:controller,sender: nil))
                    }
                })
                
            } else {
                let alert:AlertModel = AlertModel(mensagem: "As senhas informadas não são iguais", titulo: "Senha Incorreta")
                completion(alert.makeAlert(segue: nil,controller:controller,sender: nil))
            }
        }else {
            let alert:AlertModel = AlertModel(mensagem: "Complete todos os campos", titulo: "Campos vazios")
            completion(alert.makeAlert(segue: nil,controller:controller,sender: nil))
        }
    }
    
    // realiza o cadastro
    func register(email:String,senha:String,nome:String,completion:@escaping(Bool,AlertModel) ->Void) {
        let register = Auth.auth()
        var mensagem = ""
        var tittle = ""
        var errorRegister = false
        register.createUser(withEmail: email, password: senha, completion: { (usuario, error) in
            if error == nil {
                if usuario != nil{
                    let database = Database.database().reference()
                    let users = database.child("users")
                    let userData = ["nome":nome,"email":email]
                    users.child(usuario!.user.uid).setValue(userData)
                    mensagem = "\(nome) olaa!!"
                    tittle = "Bem vindo"
                }
           
            } else {
                let erroR = error! as NSError
                print(erroR)
                errorRegister = true
                if let codigoError = erroR.userInfo["FIRAuthErrorUserInfoNameKey"]{
                    let mensagemError = codigoError as! String
                    print(mensagemError)
                    switch mensagemError{
                    case "ERROR_INVALID_EMAIL":
                        mensagem = "\(nome) seu email e invalido!!"
                        tittle = "Email invalido"
                        break
                    case "ERROR_WEAK_PASSWORD":
                        mensagem = "\(nome) sua senha esta fraca!!"
                        tittle = "Deixe sua senha forte"
                        break
                    case "ERROR_EMAIL_ALREADY_IN_USE":
                        mensagem = "\(nome) este email ja existe!!"
                        tittle = "Email ja cadastrado"
                        break

                    default:
                        mensagem = "\(nome) erro inesperado!!"
                        tittle = "Chame o suporte"
                    }
                }
            }
            let alert:AlertModel = AlertModel(mensagem:  mensagem, titulo: tittle)

            completion(errorRegister,alert)
        })
    
    }
    //confirma que as duas senhas são iguais
    func checkPassword(senha:String,confirmarSenha:String)-> Bool {
        if senha == confirmarSenha{
            return true
        }else{
            return false
        }
    }
 
    
}
