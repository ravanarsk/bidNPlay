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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVC()
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
        
    }
    
}

//MARK: Button Actions
extension OTPVC{
    
    @objc fileprivate func verifyAction(){
        
        let view = DashboardTab.loadFromNib()
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = view
            window.makeKeyAndVisible()
        }
        
    }
    
}
