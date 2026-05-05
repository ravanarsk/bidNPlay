//
//  SoldPlayersModel.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 03/05/26.
//

import Foundation

protocol SoldPlayersDelegate: ErrorDelegate{
    func soldPlayerApiSuccess()
    func teamBidBalanceApiSuccess()
}

// MARK: - Root
struct SoldPlayersResponse: Codable {
    let status: Bool
    let message: String
    let players: [SoldPlayer]?
}

// MARK: - Player
struct SoldPlayer: Codable {
    let potPlayerID: Int?
    let potID: Int?
    let userID: Int?
    let soldStatus: String?
    let skipCount: Int?
    let bidPriceInCr: Int?
    let teamID: Int?
    let createdAt: String?
    let updatedAt: String?
    let playerName: String?
    let playerCountryCode: String?
    let playerPhone: String?
    let potName: String?
    let basePrice: Int?
    let multiPlayerStatus: Int?
    let isCaptain: Int?
    let teamName: String?
    let isViceCaptain: Int?

    enum CodingKeys: String, CodingKey {
        case potPlayerID = "pot_player_id"
        case potID = "pot_id"
        case userID = "user_id"
        case soldStatus = "sold_status"
        case skipCount = "skip_count"
        case bidPriceInCr = "bid_price_in_cr"
        case teamID = "team_id"
        case createdAt = "pot_player_created_at"
        case updatedAt = "pot_player_updated_at"
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
