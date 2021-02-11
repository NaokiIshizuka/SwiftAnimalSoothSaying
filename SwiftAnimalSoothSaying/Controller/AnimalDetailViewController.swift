//
//  AnimalDetailViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2021/02/07.
//  Copyright © 2021 Naoki Ishizuka. All rights reserved.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseFirestore

class AnimalDetailViewController: UIViewController {
    
    let docRef = Firestore.firestore().collection("animals").document("eachanimals")
    
    var animal: String?

    @IBOutlet weak var animalLabel: UILabel!
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    @IBOutlet weak var animalDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animalLabel.text = animal
        
        animalImageView.image = UIImage(named: animal!)
        
        docRef.addSnapshotListener { [self] documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            
            var animalDetail = data[animal!] as! String
            animalDetail = animalDetail.replacingOccurrences(of: " ", with: "\n")
            animalDetailLabel.text = animalDetail
        
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
