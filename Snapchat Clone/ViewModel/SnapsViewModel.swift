//
//  SnapsViewModel.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 16/01/23.
//

import Foundation
import UIKit
import FirebaseStorage


class SnapsViewModel {
    func saveImage(selectedImage:UIImageView,controller:UIViewController,descriprion:String,  completion:@escaping(UIAlertController,SnapModel?) -> Void) {
        let storage = Storage.storage().reference()
        let imagens = storage.child("Imagens")
        let  idImagem = NSUUID().uuidString
        if let selectedImage = selectedImage.image {
            if let dataImage = selectedImage.jpegData(compressionQuality: 0.5){
                let uploadImage = imagens.child("\(idImagem).jpg")
                uploadImage.putData(dataImage, metadata: nil)  { (metaData,error) in
                    if error == nil{
                        let alert:AlertModel = AlertModel(mensagem: "Upload realizado com sucesso", titulo: "Sucesso ao fazer o upload do Arquivo")
                        uploadImage.downloadURL(completion: { (url, error) in
                            if error == nil {
                                if let downloadUrl = url {
                                    let downloadString = downloadUrl.absoluteString
                                    print("\(downloadString)")
                                    let snap = SnapModel(description: descriprion, urlImage: downloadString,idImage: "\(idImagem).jpg")
                                    completion(alert.makeAlert(segue: "optionsForSend",controller:controller,sender: snap ),snap)
                                }
                            } else {
                                print("\(error!) Nada capturado")
                            }
                        })
                        
                    }else{
                        let alert:AlertModel = AlertModel(mensagem: "Upload não realizado", titulo: "Error ao fazer o upload do Arquivo")
                        completion(alert.makeAlert(segue: nil,controller:controller, sender: nil), nil  )
                    }
                }
            }
        }
    }
    
    
}
