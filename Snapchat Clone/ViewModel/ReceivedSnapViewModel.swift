//
//  ReceivedSnapViewModel.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 17/01/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
class ReceivedSnapViewModel{
    func deleteSnap(idSnap:String,completion:@escaping()->Void){
        let authentication = Auth.auth()
        if let loggedUser = authentication.currentUser?.uid {
            let database = Database.database().reference()
            let users = database.child("users")
            let snaps = users.child(loggedUser).child("snaps")
            snaps.child(idSnap).removeValue()
            completion()
        }
    }
    func deleteimage(idImage:String){
        let storage = Storage.storage().reference()
        let imagens = storage.child("Imagens")
        imagens.child(idImage).delete { error in
            if error == nil {
                print("Sucesso")
            }else{
                print("Fracasso")
            }
        }
    }
    
    
}
