//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import PopupDialog

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let error = error{
                    let title = "Error de Ingreso"
                    let message = "Error: \(error.localizedDescription)"
                    let popup = PopupDialog(title: title, message: message)
                    let buttonDismiss = DefaultButton(title: "OK", height: 60, dismissOnTap: true, action: nil)
                    popup.addButton(buttonDismiss)
                    self.present(popup, animated: true){
                        self.emailTextfield.text = ""
                        self.passwordTextfield.text = ""
                    }
                }else{
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
    
}
