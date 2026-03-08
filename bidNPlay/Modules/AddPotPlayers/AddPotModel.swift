//
//  AddPotResponse.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 25/02/26.
//

import Foundation


struct GetNoPotPlayerResponse: Codable {
    let status: Bool
    let message: String
    var players: [AddPotPlayer]
}

struct AddPotPlayerResponse: Codable {
    let status: Bool
    let message: String
    
    /** Sample output
     {
         "status": true,
         "message": "Added"
     }
     */
}

struct AddPotPlayer: Codable {
    let tournamentPlayerId: Int
    let tournamentId: Int
    let userId: Int
    let tournamentPlayerCreatedAt: String
    let tournamentPlayerUpdatedAt: String
    let noOfMatches: Int
    let noOfWins: Int
    let noOfDraws: Int
    let noOfLosses: Int
    let playerName: String
    let playerCountryCode: String
    let playerPhone: String

    
    enum CodingKeys: String, CodingKey {
        case tournamentPlayerId = "tournament_player_id"
        case tournamentId = "tournament_id"
        case userId = "user_id"
        case tournamentPlayerCreatedAt = "tournament_player_created_at"
        case tournamentPlayerUpdatedAt = "tournament_player_updated_at"
        case noOfMatches = "no_of_matches"
        case noOfWins = "no_of_wins"
        case noOfDraws = "no_of_draws"
        case noOfLosses = "no_of_losses"
        case playerName = "player_name"
        case playerCountryCode = "player_country_code"
        case playerPhone = "player_phone"
    }
}

protocol AddPotDelegate: ErrorDelegate {
    func refreshList() -> Void
}
