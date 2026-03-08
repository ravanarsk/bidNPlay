//
//  CreatePotVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 08/03/26.
//

import Foundation

class CreatePotVM {
    var delegate: CreatePotDelegate?
}

// MARK: APIs
extension CreatePotVM {
    internal func createPot(tournamentID: String, name: String, basePrice: String, allowMulti: Bool){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id":tournamentID,
            "pot_name":name,
            "base_price":basePrice,
            "multi_player_status":allowMulti ? 1 : 0,
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.createPot
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.post(urlString: listUrl, params: params, responseType: CreatePotModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                
                if (responseObj.status ?? false) == true {
                    self.delegate?.potCreated()
                } else {
                    self.delegate?.showAlertWith(msg: responseObj.message ?? "")
                }
                
//                self.response = responseObj
//                self.searchResults = self.response?.players ?? []
//                self.delegate?.refreshList()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
        }
    }
}
