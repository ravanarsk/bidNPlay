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
    
    internal func callJoinAPI(tournamentID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let joinUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.joinTournament
        debugPrint(params)
        debugPrint(joinUrl)
        NetworkManager.shared.post(urlString: joinUrl, params: params, responseType: BasicNetworkModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.reloadAPI()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func callLeaveAPI(tournamentID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let leaveUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.leaveTournament
        debugPrint(params)
        debugPrint(leaveUrl)
        NetworkManager.shared.delete(urlString: leaveUrl, params: params, responseType: BasicNetworkModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.reloadAPI()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func addTournamentTeamAPI(teamName: String, tournamentID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID,
            "team_name" : teamName
        ] as [String : Any]
        let leaveUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.tournamentAddTeam
        debugPrint(params)
        debugPrint(leaveUrl)
        NetworkManager.shared.post(urlString: leaveUrl, params: params, responseType: BasicNetworkModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.reloadAPI()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    internal func removeAsCaptainAPI( tournamentID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let leaveUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.removeAsCaptain
        debugPrint(params)
        debugPrint(leaveUrl)
        NetworkManager.shared.delete(urlString: leaveUrl, params: params, responseType: BasicNetworkModel.self) { result in
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.reloadAPI()
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
