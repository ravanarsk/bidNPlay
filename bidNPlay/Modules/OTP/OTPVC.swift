//
//  OTPVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 03/12/24.
//

import UIKit

class OTPVC: BaseVC {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewSubTitle: UILabel!
    @IBOutlet weak var OTPTF: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet var lblOTPTimer: UILabel!
    
    var email : String?
    var name: String?
    var password: String?
    var countryCode: String?
    var phone: String?
    
    fileprivate var timer: Timer?
    fileprivate var count: Int = 60
    
    fileprivate var otpVM = OTPVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVC()
        self.startTimer();
    }

}

//MARK: Init View
extension OTPVC{
    
    fileprivate func configureVC(){
        
        self.setBackButton()
        self.holderView.layer.cornerRadius = 10
        self.holderView.backgroundColor = CustomColor.bg2
        
        self.viewTitle.setViewTitleWith(title: "Verify OTP")
        self.viewSubTitle.setViewSubTitleWith(title: "Enter the otp sent to your email id")
        
        self.OTPTF.aboveOverlayTheme(placeHolder: "OTP")
        self.OTPTF.keyboardType = .numberPad
        
        self.verifyButton.setDefaultTheme(name: "Verify")
        self.resendButton.setSecondaryTheme(name: "Resend OTP")
        
        self.verifyButton.addTarget(
            self, action: #selector(verifyAction), for: .touchUpInside
        )
        self.resendButton.addTarget(
            self, action: #selector(resendOTPAction), for: .touchUpInside
        )
        
    }
    
    fileprivate func startTimer(){
        
        self.lblOTPTimer.text = "60"
        resendButton.isHidden = true
        lblOTPTimer.isHidden = false
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1,
                                          repeats: true, block: { [weak self] currentObject in
            if self?.count == 0{
                self?.timer?.invalidate()
                self?.count = 60
                self?.resendButton.isHidden = false
                self?.lblOTPTimer.isHidden = true
            }
            
            self?.count -= 1
            self?.lblOTPTimer.text = String(self?.count ?? 0)
        })
    }
    
}

//MARK: Button Actions
extension OTPVC{
    
    @objc fileprivate func verifyAction(){
        self.otpVM.delegate = self
        self.otpVM.preludeCheckToLoginAPI(
            email: self.email ?? "",
            otp: self.OTPTF.text ?? ""
        )
    }
    
    @objc fileprivate func resendOTPAction(){
        self.otpVM.delegate = self
        self.otpVM.preludeCheckToRegisterAPI(name: self.name ?? "",
                                             email: self.email ?? "",
                                             password: self.password ?? "",
                                             countryCode: self.countryCode ?? "",
                                             phone: self.phone ?? "")
    }
    
}

//MARK: View Model Delegates
extension OTPVC: LoginDelegate{
    
    func loginSuccess() {
        
        DispatchQueue.main.async {
            
            ActivityHUD().dismissProgressHUD()
            let view = DashboardTab.loadFromNib()
            if let window = UIApplication.shared.windows.first{
                window.rootViewController = view
                window.makeKeyAndVisible()
            }
            
        }
        
    }
    
    func resendOTPSuccess() {
        DispatchQueue.main.async { [weak self] in
            ActivityHUD().dismissProgressHUD()
            self?.startTimer()
        }
    }
    
}
