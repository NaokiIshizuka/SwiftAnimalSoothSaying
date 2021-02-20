//
//  ContainerViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2021/02/19.
//  Copyright © 2021 Naoki Ishizuka. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var animal = ""
    
    var characterAnimal = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail"{
            
            let container = segue.destination as! Animal2ViewController
            container.animal = animal
            container.characterAnimal = characterAnimal
            
        }
        
    }

}
