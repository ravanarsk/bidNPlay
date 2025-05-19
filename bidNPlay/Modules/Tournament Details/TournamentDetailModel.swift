//
//  TournamentDetailModel.swift
//  bidNPlay
//
//  Created by Ashin Asok on 09/12/24.
//

import Foundation

protocol TournamentDetailDelegate: ErrorDelegate{
    
    func showTournamentDetails()
    func reloadAPI()
    
}

struct TournamentDetailModel: Decodable{
    
    var status : Bool?
    var message : String?
    var admin_country_code : String?
    var admin_phone : String?
    var already_joined : Int?
    var tournament_details : TournamentDetails
    var current_round_no: Int?
    var current_round_name: String?
    var already_captain: Int?
    
}

struct TournamentDetails: Decodable{
    
    var tournament_id : Int
    var tournament_title : String?
    var tournament_description : String?
    var tournament_type : String?
    var tournament_code : String?
    var fixture_type : String?
    var tournament_max_players : Int?
    var tournament_no_of_teams : Int?
    var players_count : Int?
    
}
