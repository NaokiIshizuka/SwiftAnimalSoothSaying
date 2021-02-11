//
//  ViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/11/21.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        
        backBarButtonItem = UIBarButtonItem(title: "＜  戻る",  style: .done, target: self, action: #selector(barButtonTapped(_:)))
        
        self.navigationItem.leftBarButtonItems = [backBarButtonItem]
        
        
    }
    
    @objc func barButtonTapped(_ sender: UIBarButtonItem) {
    
        let storyboard = UIStoryboard.init(name: "animalList", bundle: nil)
        let AnimalListViewController = storyboard.instantiateViewController(withIdentifier: "AnimalListViewController")
        navigationController?.pushViewController(AnimalListViewController, animated: true)
        
    }
    
}

