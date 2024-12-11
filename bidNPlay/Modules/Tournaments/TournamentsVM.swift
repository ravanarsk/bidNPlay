//
//  TournamentsVM.swift
//  bidNPlay
//
//  Created by Ashin Asok on 07/12/24.
//

import Foundation

class TournamentsVM{
    
    fileprivate var listModel = [TournamentListDetailModel]()
    internal var delegate : TournamentsDelegate?
}

//MARK: Tournament List API
extension TournamentsVM{
    
    internal func showTournamentListing(segment: Int){
        
        let myTournament = ((segment == 0) ? 1 : 0)
        self.callTournamentListingAPI(myTournament: myTournament)
        
    }
    
    private func callTournamentListingAPI(myTournament: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "my_tournament" : myTournament,
            "offset": 1,
            "tournament_finished": 2
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.tournamentList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: TournamentListModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.listModel = responseObj.tournaments_list
                self.delegate?.showTournaments()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
}

//MARK: Model fetch
extension TournamentsVM{
    
    internal func getRowCount() -> Int{
        
        if self.listModel.count == 0{
            return 1
        }else{
            return self.listModel.count
        }
        
    }
    
    internal func getSelectedModelWith(index: Int) -> TournamentListDetailModel{
        
        return self.listModel[index]
        
    }
    
    internal func isEmpty() -> Bool{
        
        if self.listModel.count == 0{
            return true
        }else{
            return false
        }
        
    }
    
}

//MARK: Join Tournament
extension TournamentsVM{
    
    internal func callJoinTournament(code: String){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_code" : code
        ] as [String : Any]
        let joinUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.join
        debugPrint(params)
        debugPrint(joinUrl)
        NetworkManager.shared.post(urlString: joinUrl, params: params, responseType: BasicNetworkModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.joinTournamentResponse(
                    msg: (responseObj.message ?? "Unknown reponse")
                )
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
}
