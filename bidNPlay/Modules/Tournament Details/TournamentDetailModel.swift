//
//  TournamentDetailModel.swift
//  bidNPlay
//
//  Created by Ashin Asok on 09/12/24.
//

import Foundation

protocol TournamentDetailDelegate: ErrorDelegate{
    
    func showTournamentDetails()
    
}

struct TournamentDetailModel: Decodable{
    
    var status : Bool?
    var message : String?
    var admin_country_code : String?
    var admin_phone : String?
    var tournament_details : TournamentDetails
    
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
    
}
