//
//  FixtureVM.swift
//  bidNPlay
//
//  Created by Ashin Asok on 17/12/24.
//

import Foundation

class FixtureVM{
    
    var individualFixtureModel = [IndividualFixture]()
    var delegate: FixtureDelegate?
    
}

//MARK: API Calls
extension FixtureVM{
    
    internal func getIndividualFixtureList(tournamentID: Int, roundNo: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID,
            "round_no" : roundNo
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.individualFixtureList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: IndividualFixtureResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.individualFixtureModel = responseObj.fixtures
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
}
