//
//  ListViewController.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/12/25.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    var personArray = [String]()

    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "PersonCell", bundle: nil), forCellReuseIdentifier: "PersonCell")
        
        tableView.backgroundColor = UIColor(named: "662E1C")
        
        tableView.allowsSelection = false
        
        self.navigationController?.navigationBar.tintColor = .white
        
        fetchPersonData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return personArray.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
        
        cell.personLabel.text = personArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 20
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
         
        // 別の画面に遷移
        performSegue(withIdentifier: "toNextViewController", sender: nil)
        
    }
    
    func fetchPersonData(){
        
        var animal = String()
        
        let docRefUsers = db.collection("users").document(String(userID!))
        
        docRefUsers.addSnapshotListener { [self] documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            
            animal = (data["animal"] as? String)!
            

            //どこからデータを引っ張ってくるのか
            db.collection("users").whereField("animal", isEqualTo: animal)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            var person = String()
                            
                            person = document["userName"] as! String
                            
                            self.personArray.append(person)
                            
                            self.tableView.reloadData()
                            
                        }
                    }
                    
                }

        }

    }
    
}
