//
//  AnimalListViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2021/02/04.
//  Copyright © 2021 Naoki Ishizuka. All rights reserved.
//

import UIKit

class AnimalListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var loginBarButtonItem: UIBarButtonItem!
    
    let animal = ["狼", "こじか", "猿", "チーター", "黒ひょう", "ライオン", "トラ", "たぬき", "コアラ", "ゾウ", "ひつじ", "ペガサス"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:false);

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "AnimalListTableViewCell", bundle: nil), forCellReuseIdentifier: "AnimalCell")
        
        self.navigationController?.navigationBar.tintColor = .white
        
        loginBarButtonItem = UIBarButtonItem(title: "ログインして占う",  style: .done, target: self, action: #selector(barButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [loginBarButtonItem]
        
    }
    
    @objc func barButtonTapped(_ sender: UIBarButtonItem) {
    
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        navigationController?.pushViewController(ViewController, animated: true)
        
    }

}

extension AnimalListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return animal.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as! AnimalListTableViewCell
        
        cell.animalNameLabel.text = animal[indexPath.row]
        
        cell.animalImageView.image = UIImage(named: animal[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 50
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(indexPath.row)番目の行が選択されました。")
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        // 画面遷移
        // sender に渡したい値
        performSegue(withIdentifier: "next", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next" {
            // 遷移先のViewControllerを取得
            if let next = segue.destination as? AnimalDetailViewController, let index = sender as? Int {
                
                next.animal = animal[index]
                
            }
        }
        
    }
    
    
    
    
}
