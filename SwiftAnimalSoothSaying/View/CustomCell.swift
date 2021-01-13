//
//  CustomCell.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2020/12/10.
//  Copyright © 2020 Naoki Ishizuka. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell, UITextViewDelegate {
    
    var messageText: String? {
        
        didSet{
            
            guard let text = messageText else { return }
            let width = estimateFrameForTextView(text: text).width + 20
            
            messageTextViewWidthConstrains.constant = width
            
        }
        
    }

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var messageTextViewWidthConstrains: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        messageTextField.layer.cornerRadius = 15
        
        messageTextField.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func estimateFrameForTextView(text: String) -> CGRect{
        
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        messageTextField.endEditing(true)
        
    }

    
    
}
