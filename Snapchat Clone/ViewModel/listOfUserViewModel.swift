//
//  listOfUserViewModel.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 16/01/23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class listOfUserViewModel{
    func  getAllUser(completion:@escaping([UsuarioModel])->Void){
        let autenticacao = Auth.auth()
            
        let database = Database.database().reference()
        let user = database.child("users")
        var listOfUser: [UsuarioModel] = []
        user.observe(DataEventType.childAdded, with: { DataSnapshot in
            let dados = DataSnapshot.value  as? NSDictionary
            let email = dados?["email"] as! String
            let nome = dados?["nome"] as! String
            if let idUserlogged = autenticacao.currentUser?.uid {
                if idUserlogged != DataSnapshot.key{
                    let user = UsuarioModel(email:email, nome: nome, uid: DataSnapshot.key)
                    listOfUser.append(user)
                }
            }
            completion(listOfUser)
        })

    }
    func makeSnap(idUser:String,snap:SnapModel ){
        let database = Database.database().reference()
        let user = database.child("users")
        let snaps = user.child(idUser).child("snaps")
        
        let autenticacao = Auth.auth()
        if let idUserlogged = autenticacao.currentUser?.uid {
            let userLogged = user.child(idUserlogged)
            userLogged.observeSingleEvent(of: DataEventType.value) { DataSnapshot in
                let dados = DataSnapshot.value  as? NSDictionary
                let email = dados?["email"] as! String
                let nome = dados?["nome"] as! String
                let dataSnap = [
                    "de":"\(email)",
                    "nome":"\(nome)",
                    "descricao":"\(String(describing: snap.description))",
                    "urlImage":"\(String(describing: snap.urlImage))",
                    "idImage":"\(String(describing: snap.idImage))",
                ]
                
                snaps.childByAutoId().setValue (dataSnap)
                

            }
        }
        
    }
}
