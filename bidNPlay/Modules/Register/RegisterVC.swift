//
//  RegisterVC.swift
//  bidNPlay
//
//  Created by SectorQube Tech Mini on 03/12/24.
//

import UIKit

class RegisterVC: BaseVC {

    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
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
        
        self.emailTF.aboveOverlayTheme(placeHolder: "Email ID")
        self.passwordTF.aboveOverlayTheme(placeHolder: "Password")
        self.countryCodeTF.aboveOverlayTheme(placeHolder: "Select a country code")
        self.phoneNumberTF.aboveOverlayTheme(placeHolder: "Phone Number")
        self.registerButton.setDefaultTheme(name: "Register")
        
        self.passwordTF.keyboardType = .numberPad
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
        
    }
    
}

//MARK: Pick Country Code
extension RegisterVC : ADCountryPickerDelegate{
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        
        self.countryCodeTF.text = "\(name) : (\(dialCode))"
        picker.dismiss(animated: true)
        
    }
    
}
