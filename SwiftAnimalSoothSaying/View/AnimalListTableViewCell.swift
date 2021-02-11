//
//  AnimalListTableViewCell.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2021/02/04.
//  Copyright © 2021 Naoki Ishizuka. All rights reserved.
//

import UIKit

class AnimalListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    @IBOutlet weak var animalNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
