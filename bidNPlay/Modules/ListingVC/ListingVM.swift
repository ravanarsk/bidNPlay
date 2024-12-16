//
//  ListingVM.swift
//  bidNPlay
//
//  Created by Ashin Asok on 16/12/24.
//

import Foundation

class ListingVM{
    
    internal var listingView : ListingView?
    internal var delegate : ListingDelegate?
    
    fileprivate var playerModel = [Player]()
    fileprivate var teamModel = [Team]()
    fileprivate var teamPlayerModel = [TeamPlayer]()
    
}

//MARK: API Calls
extension ListingVM{
    
    internal func getPlayersList(tournamentID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.playerList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: PlayersResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.playerModel = responseObj.players
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func getTeamList(tournamentID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.teamList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: TeamsResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.teamModel = responseObj.teams
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func getTeamPlayerList(teamID: Int){
        
        ActivityHUD().showProgressHUD()
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
                self.teamPlayerModel = responseObj.players
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
}

//MARK: Model fetch
extension ListingVM{
    
    internal func getRowCount() -> Int {
        
        switch self.listingView {
            
            case .Players:
                return self.playerModel.isEmpty ? 1 : self.playerModel.count
            case .Teams:
                return self.teamModel.isEmpty ? 1 : self.teamModel.count
            case .TeamPlayers:
                return self.teamPlayerModel.isEmpty ? 1 : self.teamPlayerModel.count
            default:
                return 1
            
        }
        
    }
    
    internal func getPlayerModel(index: Int) -> Player{
        
        return self.playerModel[index]
        
    }
    
    internal func getTeamModel(index: Int) -> Team{
        
        return self.teamModel[index]
        
    }
    
    internal func getTeamPlayerModel(index: Int) -> TeamPlayer{
        
        return self.teamPlayerModel[index]
        
    }
    
    internal func isEmpty() -> Bool{
        
        switch self.listingView {
            
            case .Players:
                return self.playerModel.isEmpty
            case .Teams:
                return self.teamModel.isEmpty
            case .TeamPlayers:
                return self.teamPlayerModel.isEmpty
            default:
                return true
            
        }
        
    }
    
}
