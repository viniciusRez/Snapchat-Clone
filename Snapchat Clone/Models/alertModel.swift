//
//  checkAndMensageViewModel.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 13/01/23.
//

import Foundation
import UIKit
struct AlertModel{
    let mensagem:String
    let titulo:String
    
    init(mensagem: String, titulo: String) {
        self.mensagem = mensagem
        self.titulo = titulo
    }
    
    // mensagem
    func makeAlert(segue:String?,controller:UIViewController?,sender:Any?) -> UIAlertController {
        let alertaController = UIAlertController(title: self.titulo, message: self.mensagem, preferredStyle: .alert)
        if segue == nil{
            let actionError = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertaController.addAction(actionError)
        }else{
            let actionSucesso = UIAlertAction(title: "OK", style: .default, handler: { action in
                controller!.performSegue(withIdentifier: segue!, sender: self)
            })
            alertaController.addAction(actionSucesso)
        }
      
         
        return alertaController
    }
 }
