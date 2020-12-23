//
//  AnimalViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/12/02.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseFirestore

class AnimalViewController: UIViewController {
    
    /*
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var animalView: UIView!
    
    @IBOutlet weak var characterView: UIView!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var yourAnimalLabel: UILabel!
    
    @IBOutlet weak var animalLabel: UILabel!
    
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var allPersonalAnimalLabel: UILabel!
    
    @IBOutlet weak var animalDetailLabel: UILabel!
    
    @IBOutlet weak var yourCharacterLabel: UILabel!
    
    @IBOutlet weak var animalCharacterLabel: UILabel!
    
    @IBOutlet weak var personalityLabel: UILabel!
    
    @IBOutlet weak var detailManLabel: UILabel!
    
    @IBOutlet weak var detailWomanLabel: UILabel!
    
    var animal = String()
    
    var animalCharacter = String()
    
    var animalDetail = String()
    
    var characterDetail = String()
    
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
/*
        let docRefUsers = db.collection("users").document(String(userID!))
        
        let docRefCharacterAnimal = db.collection("animals").document("characteranimal")
        
        let docRefEachAnimal = db.collection("animals").document("eachanimals")

        docRefUsers.addSnapshotListener { [self] documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            
            animal = data["animal"] as! String
            animalCharacter = data["characterAnimal"] as! String
            
            animalLabel.text = animal
            
            animalImage.image = UIImage(named: animal)
            
            animalCharacterLabel.text = animalCharacter
            
            docRefEachAnimal.addSnapshotListener { [self] documentSnapshot, error in
                guard let document2 = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data2 = document2.data() else {
                    print("Document data was empty.")
                    return
                }
                
                animalDetail = data2[animal] as! String
                animalDetail = animalDetail.replacingOccurrences(of: " ", with: "\n")
                animalDetailLabel.text = animalDetail
                
                
                docRefCharacterAnimal.addSnapshotListener { [self] documentSnapshot, error in
                    guard let document3 = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    guard let data3 = document3.data() else {
                        print("Document data was empty.")
                        return
                    }
                    
                    characterDetail = data3[animalCharacter] as! String
                    
                    let characterDetailArray = characterDetail.components(separatedBy: " ")
                    
                    detailManLabel.text = characterDetailArray[0]
                    detailWomanLabel.text = characterDetailArray[1]
                    
                }
                
            }
            
        }*/
     
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
}
