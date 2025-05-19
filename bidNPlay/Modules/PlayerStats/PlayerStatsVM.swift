//
//  PlayerStatsVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 10/03/25.
//

import Foundation

protocol PlayerStatsDelegate: ErrorDelegate{
    func reloadTable()
}

class PlayerStatsVM {
    
    internal var tournamentID : Int!
    internal var isIndividual : Bool = false
    internal var delegate : PlayerStatsDelegate?
    
    var response: TournamentPlayerStatsResponse?
}


//MARK: APIs
extension PlayerStatsVM {
    
    internal func getStats() {
        getTournamentPlayerStat()
    }
    
    private func getTournamentPlayerStat() {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let detailUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.teamPlayerStats
        
        debugPrint(params)
        debugPrint(detailUrl)
        NetworkManager.shared.get(urlString: detailUrl, params: params, responseType: TournamentPlayerStatsResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.response = responseObj
                self.delegate?.reloadTable()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
}


import Foundation

// MARK: - Root Response
struct TournamentPlayerStatsResponse: Decodable {
    let status: Bool
    let message: String
    let table: [PlayerStats]
}

// MARK: - Player Stats
struct PlayerStats: Decodable {
    let tpsID: Int
    let tournamentID: Int
    let userID: Int
    let noOfMatches: Int
    let noOfWins: Int
    let noOfDraws: Int
    let noOfLosses: Int
    let goalsForward: Int
    let goalsAgainst: Int
    let goalsDifference: Int
    let tpsCreatedAt: String
    let tpsUpdatedAt: String
    let playerName: String
    let playerCountryCode: String
    let playerPhone: String
    let winPercentage: Double

    enum CodingKeys: String, CodingKey {
        case tpsID = "tps_id"
        case tournamentID = "tournament_id"
        case userID = "user_id"
        case noOfMatches = "no_of_matches"
        case noOfWins = "no_of_wins"
        case noOfDraws = "no_of_draws"
        case noOfLosses = "no_of_losses"
        case goalsForward = "goals_forward"
        case goalsAgainst = "goals_against"
        case goalsDifference = "goals_difference"
        case tpsCreatedAt = "tps_created_at"
        case tpsUpdatedAt = "tps_updated_at"
        case playerName = "player_name"
        case playerCountryCode = "player_country_code"
        case playerPhone = "player_phone"
        case winPercentage = "win_percentage"
    }
}
