//
//  ListingModel.swift
//  bidNPlay
//
//  Created by Ashin Asok on 16/12/24.
//

import Foundation

enum ListingView {
    case Players
    case Teams
    case TeamPlayers
    case Pots
}

protocol ListingDelegate: ErrorDelegate{
    
    func modelUpdated()
    
}

//MARK: Players Model
struct PlayersResponse: Decodable {
    
    let status: Bool?
    let message: String?
    let players: [Player]
    
}

struct Player: Decodable {
    
    let tournamentPlayerID: Int
    let tournamentID: Int
    let userID: Int
    let playerName: String?
    let playerCountryCode: String
    let playerPhone: String
    
    enum CodingKeys: String, CodingKey {
        
        case tournamentPlayerID = "tournament_player_id"
        case tournamentID = "tournament_id"
        case userID = "user_id"
        case playerName = "player_name"
        case playerCountryCode = "player_country_code"
        case playerPhone = "player_phone"
        
    }
    
}

//MARK: Team Model
struct TeamsResponse: Decodable {
    
    let status: Bool?
    let message: String?
    let teams: [Team]
    
}

struct Team: Decodable {
    
    let teamID: Int
    let teamName: String
    let teamCode: String?
    let tournamentID: Int
    let captainUserID: Int?
    let vcUserID: Int?
    let captainUserName: String?
    
    enum CodingKeys: String, CodingKey {
        
        case teamID = "team_id"
        case teamName = "team_name"
        case teamCode = "team_code"
        case tournamentID = "tournament_id"
        case captainUserID = "captain_user_id"
        case vcUserID = "vc_user_id"
        case captainUserName = "captain_user_name"
        
    }
    
}

//MARK: Team Players
struct TeamPlayersResponse: Decodable {
    
    let status: Bool?
    let message: String?
    let players: [TeamPlayer]
    let isTeamCaptain: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case status
        case message
        case players
        case isTeamCaptain = "is_team_captain"
        
    }
    
}

struct TeamPlayer: Decodable {
    
    let potPlayerID: Int?
    let potID: Int?
    let userID: Int
    let soldStatus: String?
    let skipCount: Int?
    let bidPriceInCr: Int?
    let teamID: Int
    let playerName: String?
    let playerCountryCode: String
    let playerPhone: String
    let potName: String?
    let basePrice: String?
    let multiPlayerStatus: String?
    let isCaptain: Int
    let teamName: String
    let isViceCaptain: Int
    
    enum CodingKeys: String, CodingKey {
        
        case potPlayerID = "pot_player_id"
        case potID = "pot_id"
        case userID = "user_id"
        case soldStatus = "sold_status"
        case skipCount = "skip_count"
        case bidPriceInCr = "bid_price_in_cr"
        case teamID = "team_id"
        case playerName = "player_name"
        case playerCountryCode = "player_country_code"
        case playerPhone = "player_phone"
        case potName = "pot_name"
        case basePrice = "base_price"
        case multiPlayerStatus = "multi_player_status"
        case isCaptain = "is_captain"
        case teamName = "team_name"
        case isViceCaptain = "is_vice_captain"
        
    }
    
}

