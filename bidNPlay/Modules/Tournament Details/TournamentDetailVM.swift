//
//  TournamentDetailVM.swift
//  bidNPlay
//
//  Created by Ashin Asok on 09/12/24.
//

import Foundation

class TournamentDetailVM{
    
    fileprivate var model : TournamentDetailModel?
    internal var delegate : TournamentDetailDelegate?
    
}

//MARK: API Listing
extension TournamentDetailVM{
    
    internal func callTournamentDetailAPI(tournamentID: Int, isIndividual: Bool){
        
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
                self.model = responseObj
                self.delegate?.showTournamentDetails()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
}

//MARK: Model Fetch
extension TournamentDetailVM{
    
    internal func getSelectedModelWith() -> TournamentDetailModel{
        
        if self.model != nil{
            return self.model!
        }
        return TournamentDetailModel(tournament_details:
                TournamentDetails(
                    tournament_id: 0
                )
        )
        
    }
    
}
