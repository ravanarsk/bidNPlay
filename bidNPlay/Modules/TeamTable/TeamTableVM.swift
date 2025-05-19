//
//  TeamTableVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 11/03/25.
//

import Foundation

protocol TeamTableDelegate: ErrorDelegate{
    func reloadTable()
}

class TeamTableVM {
    
    internal var tournamentID : Int!
    internal var isIndividual : Bool = false
    internal var delegate : TeamTableDelegate?
    
    var teamResponse: TeamTournamentTableStatResponse?
    var individualResponse: IndividualTournamentTableStatResponse?
    
    
    init() {
        
    }
    
}

//MARK: APIs
extension TeamTableVM {
    
    internal func getTableStats() {
        if isIndividual {
            getIndividualTableStat()
        } else {
            getTeamTableStat()
        }
    }
    
    private func getIndividualTableStat() {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let detailUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.individualTournamentTable
        
        debugPrint(params)
        debugPrint(detailUrl)
        NetworkManager.shared.get(urlString: detailUrl, params: params, responseType: IndividualTournamentTableStatResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.individualResponse = responseObj
                self.delegate?.reloadTable()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    private func getTeamTableStat() {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let detailUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.teamTournamentTable
        
        debugPrint(params)
        debugPrint(detailUrl)
        NetworkManager.shared.get(urlString: detailUrl, params: params, responseType: TeamTournamentTableStatResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.teamResponse = responseObj
                self.delegate?.reloadTable()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
}

struct TeamTournamentTableStatResponse: Decodable {
    let status: Bool
    let message: String
    let table: [TeamTableStat]
}

struct TeamTableStat: Decodable {
    let tttID: Int
    let tournamentID: Int
    let teamID: Int
    let noOfMatches: Int
    let noOfWins: Int
    let noOfDraws: Int
    let noOfLosses: Int
    let points: Int
    let goalsForward: Int
    let goalsAgainst: Int
    let goalsDifference: Int
    let tableCreatedAt: String
    let tableUpdatedAt: String
    let teamName: String

    enum CodingKeys: String, CodingKey {
        case tttID = "ttt_id"
        case tournamentID = "tournament_id"
        case teamID = "team_id"
        case noOfMatches = "no_of_matches"
        case noOfWins = "no_of_wins"
        case noOfDraws = "no_of_draws"
        case noOfLosses = "no_of_losses"
        case points
        case goalsForward = "goals_forward"
        case goalsAgainst = "goals_against"
        case goalsDifference = "goals_difference"
        case tableCreatedAt = "table_created_at"
        case tableUpdatedAt = "table_updated_at"
        case teamName = "team_name"
    }
}


struct IndividualTournamentTableStatResponse: Codable {
    let status: Bool
    let message: String
    let table: [IndividualTableStat]
}

struct IndividualTableStat: Codable {
    let ittID: Int
    let tournamentID: Int
    let userID: Int
    let noOfMatches: Int
    let noOfWins: Int
    let noOfDraws: Int
    let noOfLosses: Int
    let points: Int
    let goalsForward: Int
    let goalsAgainst: Int
    let goalsDifference: Int
    let individualTableCreatedAt: String
    let individualTableUpdatedAt: String
    let userName: String
    let userPhone: String
    let userCountryCode: String

    enum CodingKeys: String, CodingKey {
        case ittID = "itt_id"
        case tournamentID = "tournament_id"
        case userID = "user_id"
        case noOfMatches = "no_of_matches"
        case noOfWins = "no_of_wins"
        case noOfDraws = "no_of_draws"
        case noOfLosses = "no_of_losses"
        case points
        case goalsForward = "goals_forward"
        case goalsAgainst = "goals_against"
        case goalsDifference = "goals_difference"
        case individualTableCreatedAt = "individual_table_created_at"
        case individualTableUpdatedAt = "individual_table_updated_at"
        case userName = "user_name"
        case userPhone = "user_phone"
        case userCountryCode = "user_country_code"
    }
}


