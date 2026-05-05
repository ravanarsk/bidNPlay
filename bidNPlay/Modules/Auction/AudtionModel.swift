//
//  AudtionModel.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 23/04/26.
//

import Foundation

protocol AuctionDelegate: ErrorDelegate{
    func showAuctionDetails()
//    func showTeamBidBalance()
//    func auctionActionSuccess()
    func startAuctionSuccess()
    func submitBidSuccess()
    func soldPlayerSuccess(_ response: BasicNetworkModel?)
    func skipPlayerSuccess()
}

enum AuctionAction {
    case none
    case startAuction
    case submitBid
    case soldPlayer
    case skipPlayer
    case addAuctionViewer
    case auctionSoldPlayers
}

// MARK: - Welcome
struct AuctionDetails: Codable {
    let status: Bool?
    let message: String?
    let potPlayer: ADPotPlayer?
    let isCaptain, isAdmin: Int?
    let tournamentDetails: ADTournamentDetails?
    let captainName, teamName: String?
    let playerStats: ADPlayerStats?

    enum CodingKeys: String, CodingKey {
        case status, message
        case potPlayer = "pot_player"
        case isCaptain = "is_captain"
        case isAdmin = "is_admin"
        case tournamentDetails = "tournament_details"
        case captainName = "captain_name"
        case teamName = "team_name"
        case playerStats = "player_stats"
    }
}

extension AuctionDetails {
    static let empty = AuctionDetails(
        status: false,
        message: "",
        potPlayer: nil,
        isCaptain: 0,
        isAdmin: 0,
        tournamentDetails: ADTournamentDetails.empty,
        captainName: nil,
        teamName: nil,
        playerStats: nil
    )
}

// MARK: - PlayerStats
struct ADPlayerStats: Codable {
    let gpsID, gameID, userID, noOfMatches: Int?
    let noOfWins, noOfDraws, noOfLosses, goalsForward: Int?
    let goalsAgainst, goalsDifference: Int?
    let gpsCreatedAt, gpsUpdatedAt, playerName, playerCountryCode: String?
    let playerPhone: String?
    let winPercentage: Double?

    enum CodingKeys: String, CodingKey {
        case gpsID = "gps_id"
        case gameID = "game_id"
        case userID = "user_id"
        case noOfMatches = "no_of_matches"
        case noOfWins = "no_of_wins"
        case noOfDraws = "no_of_draws"
        case noOfLosses = "no_of_losses"
        case goalsForward = "goals_forward"
        case goalsAgainst = "goals_against"
        case goalsDifference = "goals_difference"
        case gpsCreatedAt = "gps_created_at"
        case gpsUpdatedAt = "gps_updated_at"
        case playerName = "player_name"
        case playerCountryCode = "player_country_code"
        case playerPhone = "player_phone"
        case winPercentage = "win_percentage"
    }
}

extension ADPlayerStats {
    static let empty = ADPlayerStats(
        gpsID: 0,
        gameID: 0,
        userID: 0,
        noOfMatches: 0,
        noOfWins: 0,
        noOfDraws: 0,
        noOfLosses: 0,
        goalsForward: 0,
        goalsAgainst: 0,
        goalsDifference: 0,
        gpsCreatedAt: "",
        gpsUpdatedAt: "",
        playerName: "",
        playerCountryCode: "",
        playerPhone: "",
        winPercentage: 0
    )
}

// MARK: - PotPlayer
struct ADPotPlayer: Codable {
    let potPlayerID, potID, userID: Int?
    let soldStatus: String?
    let skipCount, bidPriceInCR: Int?
    let teamID: Int?
    let potPlayerCreatedAt, potPlayerUpdatedAt, playerName, playerCountryCode: String?
    let playerPhone, potName: String?
    let basePrice, multiPlayerStatus, isCaptain: Int?
    let teamName: String?
    let isViceCaptain: Int?

    enum CodingKeys: String, CodingKey {
        case potPlayerID = "pot_player_id"
        case potID = "pot_id"
        case userID = "user_id"
        case soldStatus = "sold_status"
        case skipCount = "skip_count"
        case bidPriceInCR = "bid_price_in_cr"
        case teamID = "team_id"
        case potPlayerCreatedAt = "pot_player_created_at"
        case potPlayerUpdatedAt = "pot_player_updated_at"
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

extension ADPotPlayer {
    static let empty = ADPotPlayer(
        potPlayerID: 0,
        potID: 0,
        userID: 0,
        soldStatus: "",
        skipCount: 0,
        bidPriceInCR: 0,
        teamID: 0,
        potPlayerCreatedAt: "",
        potPlayerUpdatedAt: "",
        playerName: "",
        playerCountryCode: "",
        playerPhone: "",
        potName: "",
        basePrice: 0,
        multiPlayerStatus: 0,
        isCaptain: 0,
        teamName: "",
        isViceCaptain: 0
    )
}

// MARK: - TournamentDetails
struct ADTournamentDetails: Codable {
    let tournamentID: Int?
    let tournamentTitle: String?
    let userID, gameID: Int?
    let tournamentDescription, tournamentCode, tournamentType: String?
    let isPrivate: Int?
    let fixtureType: String?
    let tournamentMaxPlayers, tournamentNoOfTeams: Int?
    let tournamentAuctionStatus: String?
    let tournamentTotalBidPriceInCR, tournamentFinished: Int?
    let tournamentCreatedAt, tournamentUpdatedAt: String?
    let winnerTeamID: Int?
    let winnerUserID: Int?
    let winnerTeamName: String?
    let winnerUserName: String?

    enum CodingKeys: String, CodingKey {
        case tournamentID = "tournament_id"
        case tournamentTitle = "tournament_title"
        case userID = "user_id"
        case gameID = "game_id"
        case tournamentDescription = "tournament_description"
        case tournamentCode = "tournament_code"
        case tournamentType = "tournament_type"
        case isPrivate = "is_private"
        case fixtureType = "fixture_type"
        case tournamentMaxPlayers = "tournament_max_players"
        case tournamentNoOfTeams = "tournament_no_of_teams"
        case tournamentAuctionStatus = "tournament_auction_status"
        case tournamentTotalBidPriceInCR = "tournament_total_bid_price_in_cr"
        case tournamentFinished = "tournament_finished"
        case tournamentCreatedAt = "tournament_created_at"
        case tournamentUpdatedAt = "tournament_updated_at"
        case winnerTeamID = "winner_team_id"
        case winnerUserID = "winner_user_id"
        case winnerTeamName = "winner_team_name"
        case winnerUserName = "winner_user_name"
    }
}

extension ADTournamentDetails {
    static let empty = ADTournamentDetails(
        tournamentID: 0,
        tournamentTitle: "",
        userID: 0,
        gameID: 0,
        tournamentDescription: "",
        tournamentCode: "",
        tournamentType: "",
        isPrivate: 0,
        fixtureType: "",
        tournamentMaxPlayers: 0,
        tournamentNoOfTeams: 0,
        tournamentAuctionStatus: "",
        tournamentTotalBidPriceInCR: 0,
        tournamentFinished: 0,
        tournamentCreatedAt: "",
        tournamentUpdatedAt: "",
        winnerTeamID: 0,
        winnerUserID: nil,
        winnerTeamName: "",
        winnerUserName: nil
    )
}

struct TeamBidBalanceResponse: Codable {
    let status: Bool?
    let message: String?
    let teams: [AuctionTeamBalance]?
}

struct AuctionTeamBalance: Codable {
    
    let teamID: Int?
        let teamName: String?
        let teamCode: String?
        let tournamentID: Int?
        let captainUserID: Int?
        let vcUserID: Int?
        let createdAt: String?
        let updatedAt: String?
        let captainName: String?
        let totalBidPriceInCr: Int?
        let teamTotalBid: Int?
        let balance: Int?
        let captainUserName: String?

        enum CodingKeys: String, CodingKey {
            case teamID = "team_id"
            case teamName = "team_name"
            case teamCode = "team_code"
            case tournamentID = "tournament_id"
            case captainUserID = "captain_user_id"
            case vcUserID = "vc_user_id"
            case createdAt = "tournament_team_created_at"
            case updatedAt = "tournament_team_updated_at"
            case captainName = "captain_name"
            case totalBidPriceInCr = "tournament_total_bid_price_in_cr"
            case teamTotalBid = "team_total_bid"
            case balance
            case captainUserName = "captain_user_name"
        }
    
//    let teamID: Int?
//    let teamName: String?
//    let teamCode: String?
//    let captainUserName: String?
//    let teamBalanceInCR: Int?
//    let teamBidBalanceInCR: Int?
//    let teamSpentBalanceInCR: Int?
//    let tournamentTotalBidPriceInCR: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case teamID = "team_id"
//        case teamName = "team_name"
//        case teamCode = "team_code"
//        case captainUserName = "captain_user_name"
//        case teamBalanceInCR = "team_balance_in_cr"
//        case teamBidBalanceInCR = "team_bid_balance_in_cr"
//        case teamSpentBalanceInCR = "team_spent_balance_in_cr"
//        case tournamentTotalBidPriceInCR = "tournament_total_bid_price_in_cr"
//    }
    
//    internal func balanceText() -> String {
//        if let teamBalanceInCR {
//            return "\(teamBalanceInCR) Cr"
//        }
//        if let teamBidBalanceInCR {
//            return "\(teamBidBalanceInCR) Cr"
//        }
//        if let teamSpentBalanceInCR {
//            return "\(teamSpentBalanceInCR) Cr"
//        }
//        return "N/A"
//    }
}
