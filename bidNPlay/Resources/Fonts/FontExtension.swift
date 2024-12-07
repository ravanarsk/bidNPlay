//
//  FontExtension.swift
//  bidNPlay
//
//  Created by Ashin Asok on 02/12/24.
//

import UIKit

extension UIFont{
    
    internal func boldFontWith(size: CGFloat) -> UIFont{
        return UIFont(name: "Poppins-Bold", size: size) ?? UIFont.systemFont(ofSize: size,weight: .bold)
    }
    
    internal func regularFontWith(size: CGFloat) -> UIFont{
        return UIFont(name: "Poppins-Regular", size: size) ?? UIFont.systemFont(ofSize: size,weight: .regular)
    }
    
    internal func lightFontWith(size: CGFloat) -> UIFont{
        return UIFont(name: "Poppins-Light", size: size) ?? UIFont.systemFont(ofSize: size,weight: .light)
    }
    
    internal func semiBoldFontWith(size: CGFloat) -> UIFont{
        return UIFont(name: "Poppins-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size,weight: .semibold)
    }
    
    internal func mediumFontWith(size: CGFloat) -> UIFont{
        return UIFont(name: "Poppins-Medium", size: size) ?? UIFont.systemFont(ofSize: size,weight: .medium)
    }
    
}
