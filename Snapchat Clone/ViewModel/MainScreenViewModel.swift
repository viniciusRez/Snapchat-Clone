//
//  MainScreenViewModel.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 16/01/23.
//
import UIKit
import FirebaseAuth
import Foundation
import FirebaseAuth
import FirebaseDatabase
class MainScreenViewModel {
    
    var controller:UIViewController
    init(controller: UIViewController) {
        self.controller = controller
        
    }
    func singOut(){
        let authentication = Auth.auth()
        do{
            try authentication.signOut()
            self.controller.dismiss(animated: true)
        }catch{
            print(error)
        }
        
    }
    func router(identifier:String,sender:Any?) {
        self.controller.performSegue(withIdentifier: identifier, sender: sender)
        
    }
    func getSnaps(completion:@escaping([SnapModel])->Void){
        let autenticacao = Auth.auth()
        
        let database = Database.database().reference()
        let user = database.child("users")
        var listOfSnaps: [SnapModel] = []
        if let idUserlogged = autenticacao.currentUser?.uid {
            let snaps = user.child(idUserlogged).child("snaps")
            snaps.observe(DataEventType.childAdded) { snapshot in
                if let data = snapshot.value as? NSDictionary {
                    let description:String = data["descricao"] as! String
                    let urlImage:String = data["urlImage"] as! String
                    let idImage:String = data["idImage"] as! String
                    let nome:String = data["nome"] as! String
                    let de:String = data["de"] as! String
                    let identifier = snapshot.key
                    let snap = SnapModel(description: description, urlImage: urlImage, idImage: idImage, nome: nome, identifier: identifier, de: de)
                    listOfSnaps.append(snap)
                    
                }
                completion(listOfSnaps)
            }
            
        }
        
    }
    
    func getSnapsAffterDelete(completion:@escaping(String)->Void){
        let autenticacao = Auth.auth()
        
        let database = Database.database().reference()
        let user = database.child("users")
        if let idUserlogged = autenticacao.currentUser?.uid {
            let snaps = user.child(idUserlogged).child("snaps")
            snaps.observe(DataEventType.childRemoved) { snapshot in
                completion(snapshot.key)
            }
            
        }
        
    }
    
}

