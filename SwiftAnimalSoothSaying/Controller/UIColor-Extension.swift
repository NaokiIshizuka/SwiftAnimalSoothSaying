//
//  UIColor-Extension.swift
//  SwiftAnimalSoothSaying
//
//  Created by 石塚直樹 on 2021/01/02.
//  Copyright © 2021 Naoki Ishizuka. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red:CGFloat, green:CGFloat, blue:CGFloat) ->UIColor {
        
        return self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        
    }
    
}
