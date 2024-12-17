//
//  FixtureRoundVM.swift
//  bidNPlay
//
//  Created by Ashin Asok on 17/12/24.
//

import Foundation

class FixtureRoundVM{
    
    var delegate: RoundDelegate?
    var listModel = [Round]()
    
}

//MARK: API Calls
extension FixtureRoundVM{
    
    internal func getIndividualFixtureRoundList(tournamentID: Int){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID),
            "tournament_id" : tournamentID
        ] as [String : Any]
        let listUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.individualFixtureRoundsList
        debugPrint(params)
        debugPrint(listUrl)
        NetworkManager.shared.get(urlString: listUrl, params: params, responseType: RoundsResponse.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.listModel = responseObj.rounds
                self.delegate?.modelUpdated()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
}

//MARK: Model fetch
extension FixtureRoundVM{
    
    internal func getRowCount() -> Int{
        
        if self.listModel.count == 0{
            return 1
        }else{
            return self.listModel.count
        }
        
    }
    
    internal func getSelectedModelWith(index: Int) -> Round{
        
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
