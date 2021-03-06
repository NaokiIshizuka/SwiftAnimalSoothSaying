//
//  ExamineAnimalViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2021/02/19.
//  Copyright © 2021 Naoki Ishizuka. All rights reserved.
//

import UIKit

class ExamineAnimalViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var monthTextField: UITextField!
    
    @IBOutlet weak var dayTextField: UITextField!
    
    @IBOutlet weak var examineButton: UIButton!
    
    let table = [37, 8, 36, 7, 37, 8, 38, 9, 40, 10, 41, 11]
    
    let animal = ["チーター", "たぬき", "猿", "コアラ", "黒ひょう", "トラ", "チーター", "たぬき", "猿", "コアラ", "こじか", "ゾウ", "狼", "ひつじ", "猿", "コアラ", "こじか", "ゾウ", "狼", "ひつじ", "ペガサス", "ペガサス", "ひつじ", "狼", "狼", "ひつじ", "ペガサス", "ペガサス", "ひつじ", "狼", "ゾウ", "こじか", "コアラ", "猿", "ひつじ", "狼", "ゾウ", "こじか", "コアラ", "猿", "たぬき", "チーター", "トラ", "黒ひょう", "コアラ", "猿", "たぬき", "チーター", "トラ", "黒ひょう", "ライオン", "ライオン", "黒ひょう", "トラ", "トラ", "黒ひょう", "ライオン", "ライオン", "黒ひょう", "トラ"]
 
    let characterAnimal = ["長距離ランナーのチーター", "社交家のたぬき", "落ち着きの無い猿", "フットワークの軽いコアラ", "面倒見のいい黒ひょう", "愛情あふれるトラ", "全力疾走するチーター", "磨き上げられたたぬき", "大きな志をもった猿", "母性豊かなコアラ", "正直なこじか", "人気者のゾウ", "根が明るいの狼", "協調性のないひつじ", "どっしりした猿", "コアラの中のコアラ", "強い意志をもったこじか", "デリケートなゾウ", "放浪の狼", "物静かなひつじ", "落ち着きのあるペガサス", "強靭な翼を持つペガサス", "無邪気なひつじ", "クリエイティブな狼", "穏やかな狼", "粘り強いひつじ", "波乱に満ちたペガサス", "優雅なペガサス", "チャレンジ精神旺盛なひつじ", "順応性のある狼", "リーダーとなるゾウ", "しっかり者のこじか", "活動的なコアラ", "気分屋の猿", "頼られると嬉しいひつじ", "好感をもたれる狼", "まっしぐらに突き進むゾウ", "華やかなこじか", "夢とロマンのコアラ", "尽くす猿", "大器晩成のたぬき", "足腰の強いチーター", "動きまわるトラ", "情熱的な黒ひょう", "サービス精神旺盛なコアラ", "守りの猿", "人間味あふれるたぬき", "品格のあるチーター", "ゆったりとした悠然のトラ", "落ち込みの激しい黒ひょう", "我が道を行くライオン", "統率力のあるライオン", "表情豊かな黒ひょう", "楽天的なトラ", "パワフルなトラ", "気どらない黒ひょう", "感情的なライオン", "傷つきやすいライオン", "束縛を嫌う黒ひょう", "慈悲深いトラ"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        examineButton.layer.cornerRadius = 10
        
        yearTextField.delegate = self
        monthTextField.delegate = self
        dayTextField.delegate = self
        
        
    }
    
    
    @IBAction func nextExamineButton(_ sender: Any) {
        
        let year = yearTextField.text!
        let month = monthTextField.text!
        let day = dayTextField.text!
        
        let animalNumber = table(year: year, month: month, day: day)
        
        let storyboard = self.storyboard!
                
        let next = storyboard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        next.animal = animal[animalNumber-1]
        next.characterAnimal = characterAnimal[animalNumber-1]
        self.present(next, animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
    
}
