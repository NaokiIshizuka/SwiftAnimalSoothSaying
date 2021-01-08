//
//  Message.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/12/11.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import Foundation
import Firebase

class Message{
    
    var sender:String = ""
    var message:String = ""
    var createdAt: Timestamp
    
    init(dic: [String: Any]){
        
        self.sender = dic["sender"] as? String ?? ""
        self.message = dic["message"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        
    }
    
}
