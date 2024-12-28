//
//  CommonDelegates.swift
//  bidNPlay
//
//  Created by Ashin Asok on 07/12/24.
//

import Foundation

protocol ErrorDelegate{
    
    func showAlertWith(error: Error)
    func showAlertWith(msg: String)
    func popAlertWith(msg: String)
    func invalidToken()
    
}
