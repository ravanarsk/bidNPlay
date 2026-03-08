//
//  CreatePotModel.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 08/03/26.
//

import Foundation

struct CreatePotModel: Decodable{
    var status : Bool?
    var message : String?
}

protocol CreatePotDelegate: ErrorDelegate {
    func potCreated()
}
