//
//  LoginVM.swift
//  bidNPlay
//
//  Created by SectorQube Tech Mini on 07/12/24.
//

import Foundation

class LoginVM{
    
    var delegate : LoginDelegate?
    
}

//MARK: Check inputs
extension LoginVM{
    
    internal func preludeCheckToLoginAPI(email: String, password: String){
        
        if ValidationMethods().isValidEmail(email: email) == false{
            self.delegate?.popAlertWith(msg: "Enter valid email")
        }else if password.replacingOccurrences(of: " ", with: "") == ""{
            self.delegate?.popAlertWith(msg: "Enter valid password")
        }else{
            self.callLoginAPI(email: email, password: password)
        }
        
    }
    
}

//MARK: Login API
extension LoginVM{
    
    private func callLoginAPI(email: String, password: String){
        
        ActivityHUD().showProgressHUD()
        let params = [
            "email" : email,
            "password" : password
        ] as [String : Any]
        let loginUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.login
        debugPrint(params)
        debugPrint(loginUrl)
        NetworkManager.shared.post(urlString: loginUrl, params: params, responseType: LoginModel.self) { result in
            
            switch result{
                case .success(let responseObj):
                    print(responseObj)
                    self.saveDataFrom(model: responseObj.user_details)
                case .failure(let errorObj):
                    print(errorObj)
                    self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
    private func saveDataFrom(model: UserDetailsModel?){
        
        guard let model = model else{
            self.delegate?.popAlertWith(msg: "No data available")
            return
        }
        if let token = model.api_token{
            DefaultWrapper().setStringFor(Key: Keys.tokenID, Value: token)
        }
        if let fcm_token = model.fcm_token{
            DefaultWrapper().setStringFor(Key: Keys.fcm, Value: fcm_token)
        }
        if let user_id = model.user_id{
            DefaultWrapper().setIntFor(Key: Keys.userID, Value: user_id)
        }
        self.delegate?.loginSuccess()
        
    }
    
}
