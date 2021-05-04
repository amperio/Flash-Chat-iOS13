//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import PopupDialog

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore() // Creando una DB
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true
        // First step of using a custom designed file, a custom xib file, is to register it in the viewDidLoad method
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessage()
    }
    
    // Pull up all of the current data that's inside our database, and then used it to populate our tableView
    func loadMessage()  {
        // addSnapshotListener: Cada vez que un mensaje es enviado, se ejecutara
        //  Para mantener actualizados los datos de tus apps sin tener que recuperar toda la base de datos cada vez que haya una actualización, agrega agentes de escucha en tiempo real.
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapShoot, error) in
            self.messages = []
            if let e = error{
                print("There was an issue retrieving data from Firestore. \(e)")
            }else{
                if let document = querySnapShoot?.documents{
                    for doc in document{
                        let data = doc.data()
                        if let bodyMessage = data[K.FStore.bodyField] as? String, let senderMessage = data[K.FStore.senderField] as? String{
                            self.messages.append(Message(sender: senderMessage, body: bodyMessage))
                            // Is a god practice use DispatchQueue, whenever you're trying to manipulate the user interface, when you're inside a closure, a good idea is to get a hold of the main queue
                            DispatchQueue.main.async {
                                self.tableView.reloadData() // Trigger those data source methods again
                                // Mover la vista hacia al ultimo mensaje
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let currentUser = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: currentUser,
                                                                      K.FStore.bodyField: messageBody,
                                                                      K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error{
                    print("There was an issue saving data to firestore, \(e)")
                }
                else{
                    print("Successfully saved data.")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func btb_signOut(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            let title = "Error de Ingreso"
            let message = "Error: \(signOutError.localizedDescription)"
            let popup = PopupDialog(title: title, message: message)
            let buttonDismiss = DefaultButton(title: "OK", height: 60, dismissOnTap: true, action: nil)
            popup.addButton(buttonDismiss)
            self.present(popup, animated: true, completion: nil)
        }
    }
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        if let actualUser = Auth.auth().currentUser?.email{
            if actualUser == messages[indexPath.row].sender{
                cell.messageBuggle.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
                cell.label.textColor = UIColor(named: K.BrandColors.purple)
                cell.img_youAvatar.isHidden = true
                cell.img_avatar.isHidden = false
                
            }else{
                cell.messageBuggle.backgroundColor = UIColor(named: K.BrandColors.purple)
                cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
                cell.img_avatar.isHidden = true
                cell.img_youAvatar.isHidden = false
            }
        }
        return cell
    }
}
