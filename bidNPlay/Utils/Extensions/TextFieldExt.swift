//
//  TextFieldExt.swift
//  bidNPlay
//
//  Created by SectorQube Tech Mini on 03/12/24.
//

import UIKit

extension UITextField{
    
    func aboveOverlayTheme(placeHolder: String){
        
        self.placeholder = placeHolder
        self.backgroundColor = CustomColor.bg
        self.textColor = CustomColor.text
        
    }
    
    func normalTheme(placeHolder: String){
        
        self.placeholder = placeHolder
        self.backgroundColor = CustomColor.bg2
        self.textColor = CustomColor.text
        
    }
    
}
