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

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    //スクリーンのサイズを取得
    let screenSize = UIScreen.main.bounds.size
    
    var chatArray = [Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        //可変
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 75
        
        //キーボード
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Firebaseからデータをfetchしてくる(取得)
        fetchChatData()
        
        tableView.separatorStyle = .none
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func keyboardWillShow(_ notification:NSNotification){
        
        let keyboardHeight = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as Any) as AnyObject).cgRectValue.height
        
        messageTextField.frame.origin.y = screenSize.height - keyboardHeight - messageTextField.frame.height - 4
        
        sendButton.frame.origin.y = screenSize.height - keyboardHeight - sendButton.frame.height - 4
        
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification){
        
        messageTextField.frame.origin.y = screenSize.height - messageTextField.frame.height - 34
        
        sendButton.frame.origin.y = screenSize.height - sendButton.frame.height - 34
        
        guard let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else{return}
        
        UIView.animate(withDuration: duration) {
            
            let transform = CGAffineTransform(translationX: 0, y: 0)
            self.view.transform = transform
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        messageTextField.endEditing(true)
        self.tableView.keyboardDismissMode = .onDrag
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //メッセージの数
        return chatArray.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
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
                    
                cell.messageLabel.text = chatArray[indexPath.row].message
                cell.userNameLabel.text = chatArray[indexPath.row].sender

                    
                if cell.userNameLabel.text == name{
                        
                    cell.messageLabel.backgroundColor = UIColor.flatGreen()
                    cell.messageLabel.layer.cornerRadius = 20
                    cell.messageLabel.layer.masksToBounds = true
                        
                } else {
                    
                    cell.messageLabel.backgroundColor = UIColor.flatBlue()
                    cell.messageLabel.layer.cornerRadius = 20
                    cell.messageLabel.layer.masksToBounds = true
                        
                }
                    
            }
        cell.messageLabel.text = chatArray[indexPath.row].message
        cell.userNameLabel.text = chatArray[indexPath.row].sender
        print(cell.messageLabel.text! + "aaaaa")
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        if messageTextField.text!.count > 15{
            
            print("15文字以上です。")
            
            return
        }
        var name = String()
        var animal = String()
        let message = messageTextField.text!
        
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
            
            name = (data["userName"] as? String)!
            animal = (data["animal"] as? String)!
            
            let format = "yyyy-MM-dd HH:mm:ss Z"
            let date = Date()
            let formatter: DateFormatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateFormat = format
            let dateString = formatter.string(from: date)
            
            
            let messageInfo = ["sender":name,"message":message]
            
            db.collection(animal).document(dateString).setData(messageInfo)
        
        }
        
        print("送信完了")
        self.messageTextField.isEnabled = true
        self.sendButton.isEnabled = true
        self.messageTextField.text = ""
        //fetchChatData()
        
    }
    
    func fetchChatData(){
        
        var animal = String()
        let message = messageTextField.text!
        
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
                        //print(message.message)
                        
                    }
                    if (diff.type == .modified) {
                        print("Modified city: \(diff.document.data())")
                    }
                    if (diff.type == .removed) {
                        print("Removed city: \(diff.document.data())")
                    }
                }
            }
            
            //全てのdelegateメソッドを呼ぶ
            self.tableView.reloadData()

        }
        
    }
    
}
