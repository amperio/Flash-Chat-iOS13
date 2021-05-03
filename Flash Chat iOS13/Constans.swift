//
//  Constans.swift
//  Flash Chat iOS13
//
//  Created by Juan Navarro  on 2/26/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//
import PopupDialog

struct K {
    // Static properties (Propiedades de tipo), son propiedades que pertenecen al tipo en si, no es necesario realizar una instancia para tener acceso a la variable (propiedad).
    // Cada vez que se crea una nueva instancia de ese tipo, tiene su propio conjunto de valores de propiedad, separado de cualquier otra instancia.
    // En cambio las propiedades de instancia, son las qeu se acceden cuando creamos una instancia
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let appName = "⚡️FlashChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
