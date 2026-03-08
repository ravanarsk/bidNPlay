//
//  NibExt.swift
//  bidNPlay
//
//  Created by Ashin Asok on 02/12/24.
//

import Foundation

import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
        
    }
    
    static func loadFromSB() -> Self? {
        let vcDesc = String(describing: Self.self)
        let sb = UIStoryboard(name: String(describing: vcDesc), bundle: .main)
        let vc = sb.instantiateViewController(identifier: vcDesc) as? Self
        return vc
//        let vc1 = vc as? Self
//        return vc1
    }
}
