//
//  CreateTournamentVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 24/09/25.
//

import Foundation



class CreateTournamentVM {
    
    var delegate: CreateTournamentDelegate?
    
}

extension CreateTournamentVM {
    
    internal func createTournamentAPI(title: String,
                                      desc: String,
                                      tournamentType: String,
                                      fixtureType: String,
                                      playerCount: String,
                                      teamCount: String,
                                      isPrivate: Bool){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_title": title,
            "tournament_description": desc,
            "tournament_type": tournamentType,
            "tournament_max_players":playerCount,
            "tournament_no_of_teams":teamCount,
            "is_private": isPrivate ? 1 : 0,
            "fixture_type":fixtureType
            
        ] as [String : Any]
        let detailUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.createTournament
        debugPrint(params)
        debugPrint(detailUrl)
        
        
        NetworkManager.shared.post(urlString: detailUrl, params: params, responseType: CreateTournamentResponse.self) { [weak self] result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
//                print(responseObj)
                self?.delegate?.tournamentCreated(responseObj)
                
            case .failure(let errorObj):
                print(errorObj)
                self?.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
        
//        NetworkManager.shared.post(urlString: listUrl,
//                                   params: params,
//                                   responseType: AddFixtureResponse.self) { result in
//            switch result{
//            case .success(let responseObj):
//                print(responseObj)
//                self.delegate?.subFixtureAdded()
////                self.awayPlayersResponse = responseObj
////                self.delegate?.modelUpdated()
//            case .failure(let errorObj):
//                print(errorObj)
//                self.delegate?.showAlertWith(error: errorObj)
//            }
//         
//            
//            ActivityHUD().showProgressHUD()
//        }
        
    }
}
