//
//  ForgotPasswordModel.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 05/03/26.
//

import Foundation

protocol ForgotPasswordDelegate: ErrorDelegate {
    func passwordResetSuccess()
}

struct UpdatePasswordModel: Decodable{
    var status : Bool?
    var message : String?
    
}
