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
    private var safeAreaBottom: CGFloat{
        self.view.safeAreaInsets.bottom
    }
    
    
    private var chatInputAccessoryView: ChatInputAccessoryView = {
        
        let view = ChatInputAccessoryView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        return view
        
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        setupNotification()
        setupChatTableView()
        fetchChatData()
        
    }
    
    private func setupNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func setupChatTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor(named: "662E1C")
        tableView.allowsSelection = false
        
        tableView.keyboardDismissMode = .interactive
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print(safeAreaBottom)
        print("keyboardWillShow")
        guard let userInfo = notification.userInfo else { return }
        
        if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            
            if keyboardFrame.height <= 100 {
                
                tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
                tableView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
                return
                
            }
            
            print("keyboardFrame: " , keyboardFrame)
            let bottom = keyboardFrame.height - safeAreaBottom*2
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
            
            tableView.contentInset = contentInset
            tableView.scrollIndicatorInsets = contentInset
            
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        print("keyboardWillHide")
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: 60, right: 0)
        tableView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 60, right: 0)
        
        
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
        
        cell.messageText = chatArray[indexPath.row].message
        cell.messageTextField.text = cell.messageText
        cell.userNameLabel.text = chatArray[indexPath.row].sender
        cell.dateLabel.text = dataFormatterForDataLabel(date: chatArray[indexPath.row].createdAt.dateValue())
                
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.scrollToRow(at: IndexPath(row: chatArray.count - 1, section: 0), at:UITableView.ScrollPosition.bottom, animated: true)
        print("didselect")
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
                        let dic = diff.document.data()
                        let message = Message(dic: dic)
                        self.chatArray.append(message)
                        self.tableView.reloadData()
                        
                    }
                    
                }
            }

        }
        
    }
    
    private func dataFormatterForDataLabel(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
        
    }
    
}

