//
//  TournamentsModel.swift
//  bidNPlay
//
//  Created by Ashin Asok on 07/12/24.
//

import Foundation

protocol TournamentsDelegate : ErrorDelegate{
    
    func showTournaments()
    func joinTournamentResponse(msg: String)
    
}

struct TournamentListModel: Decodable{
    
    var status : Bool?
    var message : String?
    var tournaments_list : [TournamentListDetailModel]
}

struct TournamentListDetailModel: Decodable{
    
    var tournament_id: Int
    var tournament_title: String?
    var user_id: Int?
    var winner_team_name: String?
    var winner_user_name: String?
    var tournament_code: String
    
}
