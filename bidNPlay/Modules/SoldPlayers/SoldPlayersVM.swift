//
//  SoldPlayersVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 22/04/26.
//

import Foundation

class SoldPlayersVM {
    
    internal var response: SoldPlayersResponse?
    internal var responseTeamBidBalanceResponse: TeamBidBalanceResponse?
    var delegate: SoldPlayersDelegate?
    
}

extension SoldPlayersVM {
    func noOfItems() -> Int {
        response?.players?.count ?? 0
    }
    
    func getPlayer(at index: Int) -> SoldPlayer? {
        return response?.players?[index]
    }
}

extension SoldPlayersVM {
    internal func callAuctionSoldPlayersAPI(tournamentID: Int) {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let soldPlayersUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.auctionSoldPlayers
        debugPrint(params)
        debugPrint(soldPlayersUrl)
        NetworkManager.shared.get(urlString: soldPlayersUrl, params: params, responseType: SoldPlayersResponse.self) { result in
            
            switch result {
            case .success(let responseObj):
                print(responseObj)
                self.response = responseObj
                self.delegate?.soldPlayerApiSuccess()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func callTeamsBidBalanceAPI(tournamentID: Int) {
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let balanceUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.teamsBidBalance
        debugPrint(params)
        debugPrint(balanceUrl)
        NetworkManager.shared.get(urlString: balanceUrl, params: params, responseType: TeamBidBalanceResponse.self) { result in
            
            switch result {
            case .success(let responseObj):
                print(responseObj)
                self.responseTeamBidBalanceResponse = responseObj
//                self.delegate?.showTeamBidBalance()
                self.delegate?.teamBidBalanceApiSuccess()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
    }
}
