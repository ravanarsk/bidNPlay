//
//  SettingsModel.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 29/12/24.
//

import Foundation

protocol SettingsDelegate: ErrorDelegate {
    func userDeleteSuccess()
}

struct DeleteUser: Decodable{
    var status : Bool?
    var message : String?
}
