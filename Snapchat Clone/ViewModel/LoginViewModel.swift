//
//  ViewModel.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 13/01/23.
//

import Foundation
import Firebase
import UIKit

class LoginViewModel{

    func login(email:String,senha:String,controller:UIViewController, completion:@escaping(UIAlertController) ->Void){
        if email != "" && senha != "" {
            checkUser(email: email, senha: senha, completion:{ (result,alert) in

                if result{
                    completion(alert.makeAlert(segue: nil, controller:controller,sender: nil))
                }else{
                    completion(alert.makeAlert(segue: "loginSegue", controller:controller,sender: nil))
                }
            })
        }else {
            let alert:AlertModel = AlertModel(mensagem: "Complete todos os campos", titulo: "Campos vazios")
            completion(alert.makeAlert(segue: nil,controller:controller,sender: nil))
        }
    }
    func checkUser(email:String,senha:String,completion:@escaping(Bool,AlertModel) ->Void){
        let login = Auth.auth()
        var mensagem = ""
        var tittle = ""
        var notUser:Bool = false
        login.signIn(withEmail: email, password: senha, completion: { (result, error) in
            if error == nil {
                if result == nil{
                    mensagem = "\(email) erro ao autenticar, tente novamente!!"
                    tittle = "Erro ao autenticar"
                }else{
                    mensagem = "\(email) seja bem vindo!!"
                    tittle = "Bem vindo"
                }
           
            } else {
                let erroR = error! as NSError
                print(erroR)
                notUser = true
                if let codigoError = erroR.userInfo["FIRAuthErrorUserInfoNameKey"]{
                    let mensagemError = codigoError as! String
                    print(mensagemError)
                    switch mensagemError{
                    case "ERROR_INVALID_EMAIL":
                        mensagem = " seu email e invalido!!"
                        tittle = "Email invalido"
                        break
                    case "ERROR_WRONG_PASSWORD":
                        mensagem = "Sua senha esta incorreta!!"
                        tittle = "Confira sua senha"
                        break

                    default:
                        mensagem = "\(email ) erro inesperado!!"
                        tittle = "Chame o suporte"
                    }
                }
            }

            let alert:AlertModel = AlertModel(mensagem:  mensagem, titulo: tittle)

            completion(notUser,alert)
        })
    
        
    }
}
