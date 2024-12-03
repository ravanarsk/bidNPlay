//
//  ActivityHUD.swift
//  Ikin Fleet
//
//  Created by SQT MAC PRO on 14/06/23.
//

import UIKit
import ProgressHUD

//MARK: Progress HUD functions
class ActivityHUD : NSObject {
    
    internal func showProgressHUD(){
        
        ProgressHUD.animationType = .circleDotSpinFade
        ProgressHUD.colorAnimation = .darkGray
        ProgressHUD.colorBackground = .black
        ProgressHUD.animate(interaction: false)
        //ProgressHUD.show(nil, interaction: false)
        
    }
    
    internal func dismissProgressHUD(){
        
        ProgressHUD.dismiss()
        
    }
    
}
