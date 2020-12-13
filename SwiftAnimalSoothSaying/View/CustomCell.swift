//
//  CustomCell.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/12/10.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
