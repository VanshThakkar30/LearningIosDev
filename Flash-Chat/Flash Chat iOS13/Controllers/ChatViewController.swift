//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = Constant.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.cellIdentifier)
        
        loadMessages()
    }
    func loadMessages(){
        
        db.collection(Constant.FStore.collectionName).order(by: Constant.FStore.dateField).addSnapshotListener { querySnapshot, error in
            
            if let e = error{
                print("error in retriving data \(e)")
            } else{
                self.messages = []
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        if let messageSender = doc.data()[Constant.FStore.senderField] as? String, let messageBody = doc.data()[Constant.FStore.bodyField] as? String{
                            
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        Task {
            if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
                do {
                    let ref = try await db.collection(Constant.FStore.collectionName).addDocument(data: [
                        Constant.FStore.senderField: messageSender,
                        Constant.FStore.bodyField: messageBody,
                        Constant.FStore.dateField: Date().timeIntervalSince1970
                    ])
                } catch {
                    print("Error adding document: \(error)")
                }
            }
            messageTextfield.text = ""
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
}

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for:  indexPath)
        as! MessageCell
        cell.lable.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email{
            
            cell.leftSideImage.isHidden = true
            cell.rightSideImage.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constant.BrandColors.lightPurple)
            cell.lable.textColor = UIColor(named: Constant.BrandColors.purple)
            
        }else {
            
            cell.leftSideImage.isHidden = false
            cell.rightSideImage.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constant.BrandColors.purple)
            cell.lable.textColor = UIColor(named: Constant.BrandColors.lightPurple)
        }
        return cell
    }
    
    
}
