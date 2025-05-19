//
//  AddFixtureVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 12/05/25.
//

import Foundation

protocol AddFixtureDelegate: ErrorDelegate {
    func apiComplete()
    func subFixtureAdded()
}

class AddFixtureVM {
    
    internal var teamFixture: TeamFixture?
    
    var homePlayersResponse: TeamPlayersResponse?
    var awayPlayersResponse: TeamPlayersResponse?
    
    var selectedHomePlayer: TeamPlayer?
    var selectedAwayPlayer: TeamPlayer?
    
    var delegate: AddFixtureDelegate?
    
    var group: DispatchGroup?
}

extension AddFixtureVM {
    
    func getTeamPlayers() {
        group = DispatchGroup()
        
                ActivityHUD().showProgressHUD()
        
        getHomeTeamPlayerList(teamID: teamFixture?.homeTeamId ?? -1)
        getAwayTeamPlayerList(teamID: teamFixture?.awayTeamId ?? -1)
        
        group?.notify(queue: .main, execute: {
            self.delegate?.apiComplete()
        })
    }
    
    
    internal func getHomeTeamPlayerList(teamID: Int){
        group?.enter()
        
//        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "team_id" : teamID
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.teamPlayerList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: TeamPlayersResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.homePlayersResponse = responseObj
//                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                print(errorObj)
//                self.delegate?.showAlertWith(error: errorObj)
            }
            
            self.group?.leave()
            
        }
        
    }
    
    internal func getAwayTeamPlayerList(teamID: Int){
        
        group?.enter()
        
//        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "team_id" : teamID
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.teamPlayerList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: TeamPlayersResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.awayPlayersResponse = responseObj
//                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                print(errorObj)
//                self.delegate?.showAlertWith(error: errorObj)
            }
         
            self.group?.leave()
        }
        
    }
    
    internal func addTeamPlayerFixture() {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "home_user_id" : "\(selectedHomePlayer!.userID)",
            "away_user_id" : "\(selectedAwayPlayer!.userID)",
            "fixture_id" : "\(teamFixture!.fixtureId)"
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.addTeamPlayerFixture
        debugPrint(params)
        debugPrint(listUrl)
        
        NetworkManager.shared.post(urlString: listUrl,
                                   params: params,
                                   responseType: AddFixtureResponse.self) { result in
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.subFixtureAdded()
//                self.awayPlayersResponse = responseObj
//                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
         
            
            ActivityHUD().showProgressHUD()
        }
    }
}
