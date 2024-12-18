//
//  RegisterVM.swift
//  bidNPlay
//
//  Created by Ashin Asok on 18/12/24.
//

import Foundation

class RegisterVM{
    
    var delegate : RegisterDelegate?
    
}

//MARK: Check inputs
extension RegisterVM{
    
    internal func preludeCheckToRegisterAPI(name: String, email: String, password: String, countryCode: String, phone: String){
        
        if name.replacingOccurrences(of: " ", with: "") == ""{
            self.delegate?.popAlertWith(msg: "Enter name")
        }else if ValidationMethods().isValidEmail(email: email) == false{
            self.delegate?.popAlertWith(msg: "Enter valid email")
        }else if password.replacingOccurrences(of: " ", with: "") == ""{
            self.delegate?.popAlertWith(msg: "Enter valid password")
        }else if countryCode.replacingOccurrences(of: " ", with: "") == ""{
            self.delegate?.popAlertWith(msg: "Enter country code")
        }else if phone.replacingOccurrences(of: " ", with: "") == ""{
            self.delegate?.popAlertWith(msg: "Enter phone")
        }else{
            
            let code = countryCode.replacingOccurrences(of: "+", with: "")
            let params : [String: Any] = [
                "name" : name,
                "email" : email,
                "phone" : phone,
                "country_code" : code,
                "password" : password
            ]
            self.callRegisterAPI(params: params)
            
        }
        
    }
    
}

//MARK: Login API
extension RegisterVM{
    
    private func callRegisterAPI(params: [String: Any]){
        
        ActivityHUD().showProgressHUD()
        let registerUrl = APIURLs.baseUrl + APIURLs.api + APIURLs.register
        debugPrint(params)
        debugPrint(registerUrl)
        NetworkManager.shared.post(urlString: registerUrl, params: params, responseType: BasicNetworkModel.self) { result in
            
            switch result{
            case .success(let responseObj):
                print(responseObj)
                self.delegate?.registerSuccess()
            case .failure(let errorObj):
                print(errorObj)
                self.delegate?.showAlertWith(error: errorObj)
            }
            
        }
        
    }
    
}
