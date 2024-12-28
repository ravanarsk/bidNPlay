//
//  LoginModel.swift
//  bidNPlay
//
//  Created by Ashin Asok on 07/12/24.
//

import Foundation

protocol LoginDelegate: ErrorDelegate{
    
    func loginSuccess()
    func resendOTPSuccess() // Using Register API
    
}

struct LoginModel: Decodable{
    
    var status : Bool?
    var message : String?
    var user_details : UserDetailsModel?
    
}

struct UserDetailsModel : Decodable{
    
    var user_id : Int?
    var name : String?
    var email : String?
    var country_code : String?
    var phone : String?
    var api_token : String?
    var fcm_token : String?
    
}
