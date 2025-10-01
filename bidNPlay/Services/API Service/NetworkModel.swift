//
//  NetworkModel.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 01/10/25.
//

import Foundation

protocol BaseResponseModel {
    var status : Bool? { get set }
    var message : String? { get set }
}
