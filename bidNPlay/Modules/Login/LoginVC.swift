//
//  LoginVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 02/12/24.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var loginSubTitle: UILabel!
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleCard: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    
    fileprivate var loginVM = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

}

//MARK: Init View
extension LoginVC{
    
    fileprivate func configureView(){
        
        self.loginButton.setDefaultTheme(name: "Login")
        self.loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.forgotPassButton.setSecondaryTheme(name: "Forgot Password")
        self.forgotPassButton.addTarget(self, action: #selector(forgotPasswordAction), for: .touchUpInside)
        self.registerButton.setSecondaryTheme(name: "Register")
        self.registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        
        self.emailTF.aboveOverlayTheme(placeHolder: "Email")
        self.passwordTF.aboveOverlayTheme(placeHolder: "Password")
        
        self.holderView.layer.cornerRadius = 10
        self.holderView.backgroundColor = CustomColor.bg2
        
    }
    
}

//MARK: Button Actions
extension LoginVC{
    
    @objc fileprivate func loginAction(){
        
        self.loginVM.delegate = self
        self.loginVM.preludeCheckToLoginAPI(
            email: self.emailTF.text ?? "",
            password: self.passwordTF.text ?? ""
        )
        
    }
    
    @objc fileprivate func registerAction(){
        
        let vc = RegisterVC.loadFromNib()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc fileprivate func forgotPasswordAction(){
        
    }
    
}

//MARK: View Model Delegates
extension LoginVC : LoginDelegate{
    
    func loginSuccess() {
        
        DispatchQueue.main.sync {
            
            ActivityHUD().dismissProgressHUD()
            let vc = DashboardTab.loadFromNib()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
