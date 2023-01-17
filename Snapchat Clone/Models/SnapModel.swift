//
//  SnapModel.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 16/01/23.
//

import Foundation
struct SnapModel {
    var description:String
    var urlImage:String
    var idImage:String
    var nome:String?
    var identifier:String?
    var de:String?
    init(description: String, urlImage: String, idImage: String, nome: String? = nil, identifier: String? = nil, de: String? = nil) {
        self.description = description
        self.urlImage = urlImage
        self.idImage = idImage
        self.nome = nome
        self.identifier = identifier
        self.de = de
    }
}
