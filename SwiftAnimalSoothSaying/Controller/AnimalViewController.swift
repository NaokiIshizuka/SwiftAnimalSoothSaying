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
    
    
    @IBOutlet weak var animalLabel: UILabel!
    
    @IBOutlet weak var animalImage: UIImageView!
    
    
    @IBOutlet weak var animalDetailLabel: UILabel!
    
    @IBOutlet weak var animalCharacterLabel: UILabel!
    
    
    @IBOutlet weak var personalityLabel: UILabel!
    
    
    @IBOutlet weak var animalDetailView: UIView!
    
    
    @IBOutlet weak var logoutButton: UIButton!
    
    
    var animal = String()
    
    var animalCharacter = String()
    
    var animalDetail = String()
    
    var characterDetail = String()
    
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalDetailView.layer.cornerRadius = 10
        
        logoutButton.titleLabel?.adjustsFontSizeToFitWidth = true
        logoutButton.titleLabel?.minimumScaleFactor = 0.3

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
                    
                    let characterDetailArray = characterDetail.replacingOccurrences(of: " ", with: "\n")
                    
                    personalityLabel.text = characterDetailArray
                    
                }
                
            }
            
        }
     
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
}
