//
//  CreateTournamentVM.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 24/09/25.
//

import Foundation



class CreateTournamentVM {
    
}

extension CreateTournamentVM {
    
    internal func createTournamentAPI(tournamentID: Int, isIndividual: Bool){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        var detailUrl = APIURLs.baseUrl + APIURLs.api
        if isIndividual == true{
            detailUrl = detailUrl + APIURLs.indvidualTournamentDetail
        }else{
            detailUrl = detailUrl + APIURLs.tournamentDetail
        }
        debugPrint(params)
        debugPrint(detailUrl)
        NetworkManager.shared.get(urlString: detailUrl, params: params, responseType: TournamentDetailModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
            case .failure(let errorObj):
                print(errorObj)
                
            }
            
        }
        
    }
}
