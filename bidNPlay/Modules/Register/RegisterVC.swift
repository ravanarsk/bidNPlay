//
//  RegisterVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 03/12/24.
//

import UIKit

class RegisterVC: BaseVC {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let registerVM = RegisterVM()
    
    let countryPickerView = ADCountryPicker(style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

}

//MARK: Init View
extension RegisterVC{
    
    fileprivate func configureView(){
        
        self.setBackButton()
        self.holderView.backgroundColor = CustomColor.bg2
        self.holderView.layer.cornerRadius = 10
        
        self.countryPickerView.delegate = self
        self.countryPickerView.searchBarBackgroundColor = .white
        self.countryButton.addTarget(
            self, action: #selector(countrySelection), for: .touchUpInside
        )
        
        self.nameTF.aboveOverlayTheme(placeHolder: "Name")
        self.emailTF.aboveOverlayTheme(placeHolder: "Email ID")
        self.passwordTF.aboveOverlayTheme(placeHolder: "Password")
        self.countryCodeTF.aboveOverlayTheme(placeHolder: "Select a country code")
        self.phoneNumberTF.aboveOverlayTheme(placeHolder: "Phone Number")
        self.registerButton.setDefaultTheme(name: "Register")
        
        self.phoneNumberTF.keyboardType = .numberPad
        self.registerButton.addTarget(
            self, action: #selector(registerAction), for: .touchUpInside
        )
        
    }
    
}

//MARK: Button Actions
extension RegisterVC{
    
    @objc fileprivate func countrySelection(){
        
        self.countryPickerView.showCallingCodes = true
        self.countryPickerView.showFlags = true
        let navigation = UINavigationController(
            rootViewController: self.countryPickerView
        )
        self.present(navigation, animated: true)
        
    }
    
    @objc fileprivate func registerAction(){
        
        self.registerVM.delegate = self
        self.registerVM.preludeCheckToRegisterAPI(
            name: self.nameTF.text ?? "",
            email: self.emailTF.text ?? "",
            password: self.passwordTF.text ?? "",
            countryCode: self.countryCodeTF.text ?? "",
            phone: self.phoneNumberTF.text ?? ""
        )
        
    }
    
}

//MARK: Pick Country Code
extension RegisterVC : ADCountryPickerDelegate{
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        
        self.countryCodeTF.text = dialCode
        picker.dismiss(animated: true)
        
    }
    
}

//MARK: View Model Delegates
extension RegisterVC : RegisterDelegate{
    
    func registerSuccess() {
        
        DispatchQueue.main.async {
            
            ActivityHUD().dismissProgressHUD()
            let vc = OTPVC.loadFromNib()
            vc.email = self.emailTF.text
            vc.name = self.nameTF.text
            vc.password = self.passwordTF.text
            vc.countryCode = self.countryCodeTF.text
            vc.phone = self.phoneNumberTF.text
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
