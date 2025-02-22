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
    fileprivate var potModel = [Pot]()
    fileprivate var potPlayerModel = [PotPlayer]()
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
    
    internal func getPotList(tournamentID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.potList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: PotsResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.potModel = responseObj.pots
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func getPotPlayerList(potID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "pot_id" : potID
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.potPlayerList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: PotPlayersResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.potPlayerModel = responseObj.players
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
            case .Pots:
                return self.potModel.isEmpty ? 1 : self.potModel.count
            case .PotPlayer:
                return self.potPlayerModel.isEmpty ? 1 : self.potPlayerModel.count
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
    
    internal func getPotModel(index: Int) -> Pot{
        
        return self.potModel[index]
        
    }
    
    internal func getPotPlayerModel(index: Int) -> PotPlayer{
        
        return self.potPlayerModel[index]
        
    }
    
    internal func isEmpty() -> Bool{
        
        switch self.listingView {
            
            case .Players:
                return self.playerModel.isEmpty
            case .Teams:
                return self.teamModel.isEmpty
            case .TeamPlayers:
                return self.teamPlayerModel.isEmpty
            case .Pots:
                return self.potModel.isEmpty
            case .PotPlayer:
                return self.potPlayerModel.isEmpty
            default:
                return true
            
        }
        
    }
    
}
