//
//  textstyle.swift
//  Meme 2.0
//
//  Created by Carl Lee on 9/22/16.
//  Copyright © 2016 Carl Lee. All rights reserved.
//

import Foundation
import UIKit


class textStyle: UIViewController {
    let memeText = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0
        ] as [String : Any]
    
    func stylizeTextField(textField: UITextField){
        textField.defaultTextAttributes = memeText
        textField.textAlignment = NSTextAlignment.center
    }
}
