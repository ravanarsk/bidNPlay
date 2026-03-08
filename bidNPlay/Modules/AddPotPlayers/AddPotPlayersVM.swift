//
//  AddPotPlayersVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 25/02/26.
//

import Foundation

class AddPotPlayersVM {
    var selectedPlayers: Set<Int> = []
    
    var delegate: AddPotDelegate?
    var response: GetNoPotPlayerResponse?
    var searchResults: [AddPotPlayer] = []
}

// MARK:
extension AddPotPlayersVM {
    
    func searchData(_ data: String) -> [Int] {
        if data.isEmpty {
            searchResults = response?.players ?? []
            
            let indexes = searchResults.enumerated()
                .filter { selectedPlayers.contains($0.element.userId) }
                .map { $0.offset }
            return indexes
        } else {
            guard let players = response?.players else { return [] }
            
            let dataLowercased = data.lowercased()
            
            searchResults = players.filter { player in
                return player.playerName.lowercased().contains(dataLowercased) || player.playerPhone.lowercased().contains(dataLowercased) || player.playerCountryCode.lowercased().contains(dataLowercased)
            }
            
            let indexes = searchResults.enumerated()
                .filter { selectedPlayers.contains($0.element.userId) }
                .map { $0.offset }
            return indexes
        }
    }
}

// MARK: API
extension AddPotPlayersVM {
    internal func getNonPotPlayerList(tournamentID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.nonPotPlayerList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: GetNoPotPlayerResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                
                self.response = responseObj
                self.searchResults = self.response?.players ?? []
                self.delegate?.refreshList()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
        }
    }
    
    internal func addPlayersToPot(potID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "pot_id" : potID,
            "players" : Array(selectedPlayers)
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.addPlayersToPot
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.postWithRaw(urlString: listUrl, params: params, responseType: AddPotPlayerResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                if responseObj.status == true && responseObj.message == "Added" {
                    self.delegate?.popAlertWith(msg: "Players added to pot successfully")
                } else {
                    self.delegate?.showAlertWith(msg: responseObj.message)
                }
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
        }
    }
    
    
}
