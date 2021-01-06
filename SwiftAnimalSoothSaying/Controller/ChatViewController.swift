//
//  ChatViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/12/08.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class ChatViewController: UIViewController {
    
    private let cellId = "cellId"
    
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    var chatArray = [Message]()
    
    private var chatInputAccessoryView: ChatInputAccessoryView = {
        
        let view = ChatInputAccessoryView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        return view
        
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor(named: "662E1C")
        tableView.allowsSelection = false
        
        fetchChatData()
        
    }
    
    override var inputAccessoryView: UIView? {
        get{
            return chatInputAccessoryView
        }
        
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 50
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
                
        let docRefUsers = db.collection("users").document()
                
        docRefUsers.addSnapshotListener { [self] documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
                            
            let name = (data["userName"] as? String)!
                            
            cell.messageTextField.text = chatArray[indexPath.row].message
            cell.userNameLabel.text = chatArray[indexPath.row].sender

                            
            if cell.userNameLabel.text == name{
                                
                cell.messageTextField.backgroundColor = UIColor.flatGreen()
                cell.messageTextField.layer.cornerRadius = 20
                cell.messageTextField.layer.masksToBounds = true
                            
            } else {
                            
                cell.messageTextField.backgroundColor = UIColor.flatBlue()
                cell.messageTextField.layer.cornerRadius = 20
                cell.messageTextField.layer.masksToBounds = true
                                
            }
                            
        }
        cell.messageText = chatArray[indexPath.row].message
        cell.messageTextField.text = cell.messageText
        cell.userNameLabel.text = chatArray[indexPath.row].sender
                
        return cell

    }
    
    func fetchChatData(){
            
        var animal = String()
            
        let docRefUsers = db.collection("users").document(String(userID!))
            
        docRefUsers.addSnapshotListener { [self] documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
                
            animal = (data["animal"] as? String)!
                
            //どこからデータを引っ張ってくるのか
            let fetchDataRef = db.collection(animal)
                
            fetchDataRef.addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        let data = diff.document.data()
                        let sender = data["sender"]
                        let text = data["message"]
                        
                        let message = Message()
                        message.message = text as! String
                        message.sender = sender as! String
                        self.tableView.reloadData()
                        self.chatArray.append(message)
                        
                    }
                    
                }
            }
                
            //全てのdelegateメソッドを呼ぶ
            self.tableView.reloadData()

        }
        
    }
    
}

