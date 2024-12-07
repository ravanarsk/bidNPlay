//
//  LabelExt.swift
//  bidNPlay
//
//  Created by Ashin Asok on 03/12/24.
//

import UIKit

extension UILabel{
    
    func setViewTitleWith(title: String){
        
        self.text = text
        self.font = UIFont().mediumFontWith(size: 30)
        self.textColor = CustomColor.text
        
    }
    
    func setViewSubTitleWith(title: String){
        
        self.text = text
        self.font = UIFont().mediumFontWith(size: 14)
        self.textColor = CustomColor.text2
        
    }
    
}
