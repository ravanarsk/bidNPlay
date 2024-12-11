//
//  PlayerListingModel.swift
//  bidNPlay
//
//  Created by Ashin Asok on 11/12/24.
//

import Foundation

struct PlayerListingModel: Decodable{
    
    var status: Bool?
    var message: String?
    var players: [PlayerList]
    
}

struct PlayerList: Decodable{
    
    var tournament_player_id : Int
    var tournament_id : Int?
    var user_id : Int?
    var player_name : String?
    var player_country_code : String?
    var player_phone : String?
    
}
