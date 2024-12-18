//
//  ProfileVM.swift
//  bidNPlay
//
//  Created by Ashin Asok on 18/12/24.
//

import Foundation

class ProfileVM{
    
}

//MARK: Profile API
extension ProfileVM{
    
    internal func callProfileAPI(){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "user_id" : DefaultWrapper().getIntFrom(Key: Keys.userID)
        ] as [String : Any]
        let profileUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.profile
        debugPrint(params)
        debugPrint(profileUrl)
        NetworkManager.shared.get(urlString: profileUrl, params: params, responseType: LoginModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                
            case .failure(let errorObj):
                print(errorObj)
                // self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
}
