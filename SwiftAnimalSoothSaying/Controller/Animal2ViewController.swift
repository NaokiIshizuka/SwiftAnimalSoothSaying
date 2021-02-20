//
//  Animal2ViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2021/02/19.
//  Copyright © 2021 Naoki Ishizuka. All rights reserved.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseFirestore

class Animal2ViewController: UIViewController {
    
    var animal = "animal"
    var characterAnimal = "character"
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var animalLabel: UILabel!
    
    @IBOutlet weak var animalImage: UIImageView!
    
    
    @IBOutlet weak var animalDetailLabel: UILabel!
    
    @IBOutlet weak var animalCharacterLabel: UILabel!
    
    @IBOutlet weak var personalityLabel: UILabel!
    
    @IBOutlet weak var animalView: UIView!
    
    @IBOutlet weak var characterView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animalView.layer.cornerRadius = 10
        characterView.layer.cornerRadius = 10
        
        animalLabel.text = animal
        
        animalCharacterLabel.text = characterAnimal
        
        animalImage.image = UIImage(named: animal)
        
        let docRefCharacterAnimal = db.collection("animals").document("characteranimal")
        
        let docRefEachAnimal = db.collection("animals").document("eachanimals")
        
        docRefEachAnimal.addSnapshotListener { [self] documentSnapshot, error in
            guard let document2 = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data2 = document2.data() else {
                print("Document data was empty.")
                return
            }
            
            var animalDetail = data2[animal] as! String
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
                
                let characterDetail = data3[characterAnimal] as! String
                
                let characterDetailArray = characterDetail.replacingOccurrences(of: " ", with: "\n")
                
                personalityLabel.text = characterDetailArray
                
            }
            
        }
        
    }
    
}
