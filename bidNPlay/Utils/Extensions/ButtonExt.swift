//
//  ButtonExt.swift
//  bidNPlay
//
//  Created by Ashin Asok on 03/12/24.
//

import UIKit

extension UIButton{
    
    func setDefaultTheme(name: String, fontSize: CGFloat = 16){
        
        self.setTitle(name, for: .normal)
        self.backgroundColor = CustomColor.button
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont().mediumFontWith(size: fontSize)
        self.setTitleColor(CustomColor.text, for: .normal)
        
    }
    
    func setSecondaryTheme(name: String, fontSize: CGFloat = 14){
        
        self.setTitle(name, for: .normal)
        self.setTitleColor(CustomColor.text2, for: .normal)
        self.titleLabel?.font = UIFont().regularFontWith(size: fontSize)
        
    }
    
    func setWhatsappTheme(fontSize: CGFloat = 14){
        
        self.setTitle("  Contact admin via WhatsApp", for: .normal)
        self.setTitleColor(CustomColor.text, for: .normal)
        self.backgroundColor = CustomColor.whatsapp
        let image = UIImage(systemName: "bubble.left.and.text.bubble.right.fill")
        self.setImage(image, for: .normal)
        self.tintColor = CustomColor.text
        self.titleLabel?.font = UIFont().regularFontWith(size: fontSize)
        self.layer.cornerRadius = 10
        
    }
    
}
