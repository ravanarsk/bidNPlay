//
//  AuctionVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 22/04/26.
//

import UIKit

class AuctionVC: BaseVC {
    
    @IBOutlet var lblTotalBidAmt: UILabel!
    @IBOutlet var lblPlayerName: UILabel!
    @IBOutlet var lblPlayerStats: UILabel!
    @IBOutlet var lblPotName: UILabel!
    @IBOutlet var lblBasePrice: UILabel!
    @IBOutlet var lblCurrentBid: UILabel!
    @IBOutlet var lblStatus: UILabel!
    
    @IBOutlet var btnTeamBalance: UIButton!
    @IBOutlet var btnSkip: UIButton!
    @IBOutlet var btnSold: UIButton!
    @IBOutlet var btnStart: UIButton!
    
    @IBOutlet var stackSkipSold: UIStackView!
    
    @IBOutlet var txtBidPrice: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    
    internal var tournamentID: Int?
    
    fileprivate let auctionVM = AuctionVM()
    fileprivate var refreshTimer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.auctionVM.delegate = self
        self.callAuctionDetailAPI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.refreshTimer?.invalidate()
        self.refreshTimer = nil
    }
    
}

//MARK: View Setup
extension AuctionVC {
    
    fileprivate func configureView() {
        
        self.setBackButton()
        self.navigationItem.title = "Auction Details"
        self.view.backgroundColor = CustomColor.bg
        
        btnTeamBalance.setDefaultTheme(name: "Check Team Balance")
        btnSkip.setDefaultTheme(name: "SKIP")
        btnSold.setDefaultTheme(name: "SOLD")
        btnSubmit.setDefaultTheme(name: "SUBMIT")
        btnStart.setDefaultTheme(name: "START")
        
    }
    
}

// MARK: IBAction UIButton
extension AuctionVC {
    
    @IBAction func startAuctionAction(_ sender: UIButton) {
        startAuctionTapped()
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        if let strBid = txtBidPrice.text, let bid = Int(strBid) {
            submitBid(with: bid)
        }
    }
    
    @IBAction func skipAction(_ sender: UIButton) {
        skipPlayer()
    }
    
    @IBAction func soldAction(_ sender: UIButton) {
        soldPlayer()
    }
    
    @IBAction func checkTeamBalanceAction(_ sender: UIButton) {
        let vc = SoldPlayersVC.loadFromNib()
        vc.tournamentID = tournamentID
        vc.viewConfig = .teamBidBalance
        //            vc.modalPresentationStyle = .formSheet
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: API Calls
extension AuctionVC {
    
    fileprivate func callAuctionDetailAPI(showLoader: Bool = true) {
        
        guard let tournamentID else {
            self.showAlertWith(msg: "Tournament ID is missing")
            return
        }
        self.auctionVM.callAuctionDetailsAPI(tournamentID: tournamentID, showLoader: showLoader)
        
    }
    
    fileprivate func startAuction(with bidPrice: Int) {
        guard let tournamentID else { return }
        self.auctionVM.callStartAuctionAPI(tournamentID: tournamentID, bidPrice: bidPrice)
    }
    
    fileprivate func submitBid(with bidPrice: Int) {
        guard let tournamentID, let currentPotPlayerID = auctionVM.currentPotPlayerID else { return }
        self.auctionVM.callSubmitBidAPI(
            tournamentID: tournamentID,
            potPlayerID: currentPotPlayerID,
            bidPrice: bidPrice
        )
    }
    
    fileprivate func soldPlayer() {
        guard let currentPotPlayerID = auctionVM.currentPotPlayerID, let currentTeamID = auctionVM.currentTeamID else {
            self.showAlertWith(msg: "No bid found, please skip this player.")
            return
        }
        self.auctionVM.callSoldPlayerAPI(
            potPlayerID: currentPotPlayerID,
            bidPrice: auctionVM.playerBidPriceInCR,
            teamID: currentTeamID
        )
    }
    
    fileprivate func skipPlayer() {
        guard let currentPotPlayerID = auctionVM.currentPotPlayerID else { return }
        self.auctionVM.callSkipPlayerAPI(potPlayerID: currentPotPlayerID)
    }
    
    fileprivate func getTeamBalance() {
//        guard let tournamentID else { return }
//        self.auctionVM.callTeamsBidBalanceAPI(tournamentID: tournamentID)
    }
    
    fileprivate func addAuctionViewerIfNeeded() {
        guard let tournamentID, auctionVM.isAuctionViewerAdded == false else { return }
        auctionVM.isAuctionViewerAdded = true
        self.auctionVM.callAddAuctionViewerAPI(tournamentID: tournamentID)
    }
    
}

//MARK: Button Actions
extension AuctionVC {
    
    @objc fileprivate func startAuctionTapped() {
        
        let alertVC = UIAlertController(
            title: "Start Auction",
            message: "Enter initial bid amount",
            preferredStyle: .alert
        )
        alertVC.addTextField { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = "Bid Amount"
        }
        let startAction = UIAlertAction(title: "Start", style: .default) { [weak self] _ in
            guard let self,
                  let bidText = alertVC.textFields?.first?.text,
                  let bidPrice = Int(bidText),
                  bidPrice > 0 else {
                self?.showAlertWith(msg: "Enter a valid bid amount")
                return
            }
            self.startAuction(with: bidPrice)
        }
        alertVC.addAction(startAction)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alertVC, animated: true)
        
    }
    
    @objc fileprivate func submitBidTapped() {
        
        guard let bidText = self.txtBidPrice.text,
              let bidPrice = Int(bidText),
              bidPrice > 0 else {
            self.showAlertWith(msg: "Please enter a valid bid price")
            return
        }
        self.submitBid(with: bidPrice)
        
    }
    
    @objc fileprivate func skipPlayerTapped() {
        self.skipPlayer()
    }
    
    @objc fileprivate func soldPlayerTapped() {
        
        guard auctionVM.currentTeamID != nil, auctionVM.playerBidPriceInCR > 0 else {
            self.showAlertWith(msg: "No bid found, please skip this player.")
            return
        }
        self.soldPlayer()
        
    }
    
    @objc fileprivate func teamBalanceTapped() {
        self.getTeamBalance()
    }
    
}

//MARK: Auction Delegate
extension AuctionVC: AuctionDelegate {
    
    func showAuctionDetails() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.addAuctionViewerIfNeeded()
            let model = self.auctionVM.getSelectedModelWith()
            self.applyAuctionDetails(model)
        }
        
    }
    
//    func showTeamBidBalance() {
//        
//        DispatchQueue.main.async {
//            ActivityHUD().dismissProgressHUD()
//            self.teamBalanceList = self.auctionVM.getTeamsBidBalanceResponse()?.teams ?? []
//            if self.teamBalanceList.isEmpty {
//                self.showAlertWith(msg: "No team balance found")
//            } else {
//                let vc = TeamBalanceSheetVC()
//                vc.teams = self.teamBalanceList
//                vc.modalPresentationStyle = .pageSheet
//                if let sheet = vc.sheetPresentationController {
//                    sheet.detents = [.medium(), .large()]
//                    sheet.prefersGrabberVisible = true
//                }
//                self.present(vc, animated: true)
//            }
//        }
//        
//    }
    
//    func auctionActionSuccess() {
//        
//        DispatchQueue.main.async {
//            ActivityHUD().dismissProgressHUD()
//            
//            
//            switch action {
//            case .soldPlayer:
//                
//            case .skipPlayer:
//                
//            case .submitBid:
//                
//            case .startAuction:
//                
//            default:
//                break
//            }
//        }
//        
//    }
    
    func startAuctionSuccess() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.callAuctionDetailAPI()
        }
    }
    
    func submitBidSuccess() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.txtBidPrice.text = ""
            self.callAuctionDetailAPI()
        }
    }
    
    func soldPlayerSuccess(_ response: BasicNetworkModel?) {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
//            let response = self.auctionVM.getAuctionActionResponse()
//            let action = self.auctionVM.getCurrentAction()
            let msg = response?.message ?? "\(self.auctionVM.playerName) was sold successfully"
            self.showActionAlert(message: msg, reloadAfterDismiss: true)
        }
    }
    
    func skipPlayerSuccess() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.callAuctionDetailAPI()
        }
    }
    
}

//MARK: UI Update
extension AuctionVC {
    
    fileprivate func applyAuctionDetails(_ model: AuctionDetails) {
        
        self.refreshTimer?.invalidate()
        self.refreshTimer = nil
        
        let status = auctionVM.tournamentAuctionStatus
        
        lblTotalBidAmt.isHidden = status != "started"
        
        lblTotalBidAmt.text = "Total Bid Amount will be \(auctionVM.tournamentTotalBidPriceInCR ?? 0) Cr."
        
        lblPlayerName.text = "Player Name : \(auctionVM.playerName)"
        lblPlayerStats.text = auctionVM.playerStats.isEmpty ? "Stats unavailable" : auctionVM.playerStats
        lblPotName.text = "Pot Name : \(auctionVM.potName)"
         lblBasePrice.text = "Base Price : \(auctionVM.basePrice)"
        lblCurrentBid.text = (!auctionVM.teamName.isEmpty && !auctionVM.captainName.isEmpty) ? "Current Bid : \(auctionVM.playerBidPriceInCR) - \(auctionVM.captainName) ( \(auctionVM.teamName) )" : "Current Bid : \(auctionVM.playerBidPriceInCR)"
        
        if auctionVM.isAdmin {
            self.handleAdminUI(status: status, isCaptain: auctionVM.isCaptain, hasPlayer: auctionVM.hasPlayer)
        } else if auctionVM.isCaptain {
            self.handleCaptainUI(status: status, hasPlayer: auctionVM.hasPlayer)
        } else {
            self.handleViewerUI(status: status, hasPlayer: auctionVM.hasPlayer)
        }
    }
    
    fileprivate func handleAdminUI(status: String, isCaptain: Bool, hasPlayer: Bool) {
        
       
        
        
        
        self.btnTeamBalance.isHidden = false
        self.btnSkip.isHidden = false
        self.btnSold.isHidden = false
        self.btnSubmit.isHidden = !isCaptain
        self.txtBidPrice.isHidden = !isCaptain
        
        switch status {
        case "not_started":
            self.btnStart.isHidden = false
//            self.auctionCard.isHidden = true
            self.lblStatus.isHidden = true
        case "started":
            self.btnStart.isHidden = true
            self.showAuctionState(hasPlayer: hasPlayer, emptyMessage: "No Players found")
            self.scheduleRefresh()
        default:
            self.btnStart.isHidden = true
//            self.auctionCard.isHidden = true
            self.lblStatus.text = "Auction Finished"
            self.lblStatus.isHidden = false
        }
        
    }
    
    fileprivate func handleCaptainUI(status: String, hasPlayer: Bool) {
       
        
        
        self.btnStart.isHidden = true
        self.btnSkip.isHidden = true
        self.btnSold.isHidden = true
        self.btnSubmit.isHidden = false
        self.txtBidPrice.isHidden = false
        self.btnTeamBalance.isHidden = false
        
        switch status {
        case "not_started":
            debugPrint("")
//            self.auctionCard.isHidden = true
            self.lblStatus.text = "Auction not yet started"
            self.lblStatus.isHidden = false
        case "started":
            self.showAuctionState(hasPlayer: hasPlayer, emptyMessage: "No Players found")
            self.scheduleRefresh()
        default:
            debugPrint("")
//            self.auctionCard.isHidden = true
            self.lblStatus.text = "Auction Finished"
            self.lblStatus.isHidden = false
        }
        
    }
    
    fileprivate func handleViewerUI(status: String, hasPlayer: Bool) {
        
        self.btnStart.isHidden = true
        self.btnSkip.isHidden = true
        self.btnSold.isHidden = true
        self.btnSubmit.isHidden = true
        self.txtBidPrice.isHidden = true
        self.btnTeamBalance.isHidden = false
        
        switch status {
        case "not_started":
            debugPrint("")
//            self.auctionCard.isHidden = true
            self.lblStatus.text = "Auction not yet started"
            self.lblStatus.isHidden = false
        case "started":
            self.showAuctionState(hasPlayer: hasPlayer, emptyMessage: "No Players found")
        default:
            debugPrint("")
//            self.auctionCard.isHidden = true
            self.lblStatus.text = "Auction Finished"
            self.lblStatus.isHidden = false
        }
        
    }
    
    fileprivate func showAuctionState(hasPlayer: Bool, emptyMessage: String) {
        
        if hasPlayer {
            debugPrint("")
//            self.auctionCard.isHidden = false
            self.lblStatus.isHidden = true
        } else {
            debugPrint("")
//            self.auctionCard.isHidden = true
            self.lblStatus.text = emptyMessage
            self.lblStatus.isHidden = false
        }
        
    }
    
    fileprivate func scheduleRefresh() {
        
        self.refreshTimer?.invalidate()
        self.refreshTimer = Timer.scheduledTimer(
            withTimeInterval: 3.0,
            repeats: true
        ) { [weak self] _ in
            self?.callAuctionDetailAPI(showLoader: false)
        }
        
    }
    
    fileprivate func showActionAlert(message: String, reloadAfterDismiss: Bool) {
        
        let alertVC = UIAlertController(
            title: "",
            message: message,
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(title: CommonConstants.done, style: .default) { _ in
            if reloadAfterDismiss == true {
                self.callAuctionDetailAPI()
            }
        }
        alertVC.addAction(doneAction)
        self.present(alertVC, animated: true)
        
    }
    
}
