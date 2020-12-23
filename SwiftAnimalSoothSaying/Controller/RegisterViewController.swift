//
//  RegisterViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/11/30.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameTextFirld: UITextField!
    
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var monthTextField: UITextField!
    
    @IBOutlet weak var dayTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    var ref: DocumentReference? = nil
    let db = Firestore.firestore()
    
    let table = [37, 8, 36, 7, 37, 8, 38, 9, 40, 10, 41, 11]
    
    let animal = ["チーター", "たぬき", "猿", "コアラ", "黒ひょう", "虎", "チーター", "たぬき", "猿", "コアラ", "こじか", "ゾウ", "狼", "ひつじ", "猿", "コアラ", "こじか", "ゾウ", "狼", "ひつじ", "ペガサス", "ペガサス", "ひつじ", "狼", "狼", "ひつじ", "ペガサス", "ペガサス", "ひつじ", "狼", "ゾウ", "こじか", "コアラ", "猿", "ひつじ", "狼", "ゾウ", "こじか", "コアラ", "猿", "たぬき", "チーター", "虎", "黒ひょう", "コアラ", "猿", "たぬき", "チーター", "虎", "黒ひょう", "ライオン", "ライオン", "黒ひょう", "虎", "虎", "黒ひょう", "ライオン", "ライオン", "黒ひょう", "虎"]
 
    let characterAnimal = ["長距離ランナーのチーター", "社交的なたぬき", "落ち着きのない猿", "フットワークの軽いコアラ", "面倒見のいい黒ひょう", "愛情あふれる虎", "全力疾走するチーター", "磨き上げられたたぬき", "大きな志をもった猿", "母性豊かなコアラ", "正直なこじか", "人気者のゾウ", "根が明るいの狼", "協調性のないひつじ", "どっしりした猿", "コアラの中のコアラ", "強い意志をもったこじか", "デリケートなゾウ", "放浪の狼", "もの静かなひつじ", "落ち着きのあるペガサス", "強靭な翼をもつペガサス", "無邪気なひつじ", "クリエイティブな狼", "穏やかな狼", "ねばり強いひつじ", "波乱に満ちたペガサス", "優雅なペガサス", "チャレンジ精神の旺盛なひつじ", "順応性のある狼", "リーダーとなるゾウ", "しっかり者のこじか", "活動的なコアラ", "気分屋の猿", "頼られるとうれしいひつじ", "好感のもたれる狼", "まっしぐらに突き進むゾウ", "華やかなこじか", "夢とロマンのコアラ", "尽くす猿", "大器晩成のたぬき", "足腰の弱いチーター", "動きまわる虎", "情熱的な黒ひょう", "サービス精神旺盛なコアラ", "守りの猿", "人間味あふれるたぬき", "品格のあるチーター", "ゆったりとした悠然の虎", "落ち込みの激しい黒ひょう", "我が道をいくライオン", "統率力のあるライオン", "表情豊かな黒ひょう", "楽天的な虎", "パワフルな虎", "気どらない黒ひょう", "感情的なライオン", "傷つきやすいライオン", "束縛をきらう黒ひょう", "慈悲深い虎"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.cornerRadius = 10
        
    }
    

    @IBAction func registerButton(_ sender: Any) {
        
        let username = usernameTextFirld.text!
        let year = yearTextField.text!
        let month = monthTextField.text!
        let day = dayTextField.text!
        
        //新規登録
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { [self] (user, error) in
            
            if error != nil {
                
                print(error as Any)
                
            } else {
                
                print("ユーザーの作成が成功しました！")
                
                let userID = String(Auth.auth().currentUser!.uid)
                
                let animalNumber = table(year: year, month: month, day: day)
                
                createUser(userID: userID, username: username, year: year, month: month, day: day, animalNumber: animalNumber)
                
            }
            
        }
        
    }
    
    func createUser(userID: String, username: String, year: String, month: String, day:String, animalNumber:Int){
        
        db.collection("users").document(userID).setData([
            "userName": username,
            "year": year,
            "month": month,
            "day": day,
            "animal": animal[animalNumber-1],
            "characterAnimal": characterAnimal[animalNumber-1]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
                self.performSegue(withIdentifier: "animal", sender: nil)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        usernameTextFirld.endEditing(true)
        yearTextField.endEditing(true)
        monthTextField.endEditing(true)
        dayTextField.endEditing(true)
        
    }
    
    func table(year: String, month: String, day: String) -> Int{
        
        let year = Int(year)
        let month = Int(month)
        let day = Int(day)
        var count = 0
        
        var conversionNumber = table[month!-1]
        
        while count < (year!-1951) {
            
            count += 1
            
            if month == 1 || month == 2{
                
                if count%4 == 2 {
                    
                    conversionNumber += 6
                    
                } else {
                    
                    conversionNumber += 5
                    
                }
                
            } else {
                
                if count%4 == 1 {
                    
                    conversionNumber += 6
                    
                } else {
                    
                    conversionNumber += 5
                    
                }
                
            }
            
            if conversionNumber > 60 {
                
                conversionNumber -= 60
                
            }
            
        }
        
        conversionNumber += day!
        if conversionNumber > 60 {
            
            conversionNumber -= 60
            
        }
        
        return conversionNumber
        
    }

}
