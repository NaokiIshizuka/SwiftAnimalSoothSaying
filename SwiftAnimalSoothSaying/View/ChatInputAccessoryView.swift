//
//  ChatInputAccessaryView.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/12/31.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import UIKit
import Firebase

class ChatInputAccessoryView: UIView {
    
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func tappedSendAction(_ sender: Any) {
        
        chatTextView.endEditing(true)
        sendButton.isEnabled = false
        
        if chatTextView.text == "" {
            return
        }
                
        var name = String()
        var animal = String()
        let message = chatTextView.text!
                
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
                    
                    
            let messageInfo = ["sender":name,"message":message, "createdAt": Timestamp()] as [String : Any]
                    
            db.collection(animal).document(dateString).setData(messageInfo)
                
        }
                
        print("送信完了")
        self.sendButton.isEnabled = true
        self.chatTextView.text = ""
        
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)

        nibInit()
        setupViews()
        autoresizingMask = .flexibleHeight
        
    }
    
    private func setupViews(){
     
        chatTextView.layer.cornerRadius = 15
        chatTextView.layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230).cgColor
        chatTextView.layer.borderWidth = 1
        
        sendButton.layer.cornerRadius = 15
        sendButton.isEnabled = false
        
        chatTextView.text = ""
        chatTextView.delegate = self
        
    }
    
    
    override var intrinsicContentSize: CGSize {
        
        return .zero
        
    }
    

    private func nibInit() {
        let nib = UINib(nibName: "ChatInputAccessoryView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }

        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension ChatInputAccessoryView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        if chatTextView.text.isEmpty {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
        
    }
    
}
