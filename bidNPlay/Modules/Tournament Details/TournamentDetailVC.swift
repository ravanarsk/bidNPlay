//
//  TournamentDetailVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 05/12/24.
//

import UIKit

class TournamentDetailVC: BaseVC {

    @IBOutlet weak var listTableView: UITableView!
    internal var tournamentID : Int?
    internal var isIndividual : Bool = false
    fileprivate var detailVM = TournamentDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpView()
    }

}

//MARK: Init View
extension TournamentDetailVC{
    
    fileprivate func configureView(){
        
        self.setBackButton()
        self.listTableView.registerCells(names:[
            "DataCell",
            "HeaderCell",
            "BasicInfoCell",
            "PlayerInfoCell",
            "TeamInfoCell"
        ])
        self.listTableView.backgroundColor = CustomColor.bg
        self.listTableView.separatorStyle = .none
        self.listTableView.tableFooterView = UIView()
        self.listTableView.showsVerticalScrollIndicator = false
        self.listTableView.showsHorizontalScrollIndicator = false
        
    }
    
    fileprivate func setUpView(){
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Details"
        self.listTableView.dataSource = nil
        self.listTableView.delegate = nil
        self.callDetailAPI()
        
    }
    
}

//MARK: API Call
extension TournamentDetailVC{
    
    internal func callDetailAPI(){
        
        self.detailVM.delegate = self
        if let id = self.tournamentID{
            self.detailVM.callTournamentDetailAPI(
                tournamentID: id,
                isIndividual: self.isIndividual
            )
        }
        
    }
    
}

//MARK: View Model Delegates
extension TournamentDetailVC: TournamentDetailDelegate{
    
    func showTournamentDetails() {
        
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            if self.listTableView.delegate == nil || self.listTableView.dataSource == nil{
                self.listTableView.dataSource = self
                self.listTableView.delegate = self
            }
            self.listTableView.reloadData()
        }
        
    }
    
    func reloadAPI() {
        
        DispatchQueue.main.async {
            
            ActivityHUD().dismissProgressHUD()
            self.callDetailAPI()
            
        }
        
    }
    
}

//MARK: Tableview delegates
extension TournamentDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.detailVM.getSelectedModelWith()
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.delegate = self
            cell.setUpCell(model: model)
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerInfoCell", for: indexPath) as! PlayerInfoCell
            cell.setupCell(model: model)
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamInfoCell", for: indexPath) as! TeamInfoCell
            cell.delegate = self
            cell.setCell(model: model)
            return cell
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataCell
            cell.setUpCell(model: model)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoCell", for: indexPath) as! BasicInfoCell
            cell.delegate = self
            cell.setUpCell(model: model)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = self.detailVM.getSelectedModelWith()
        if indexPath.row == 0 || indexPath.row == 3{
            return UITableView.automaticDimension
        }else if indexPath.row == 1{
            return 190
        }else if indexPath.row == 2{
            if model.tournament_details.tournament_type == "Individual"{
                return 0
            }
            return 200
        }else{
            return 340
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1{
            self.segueToListing(viewSelection: .Players)
        }
        
    }
    
}

//MARK: Team Info Cell and Basic Info Cell Delegates
extension TournamentDetailVC: TeamInfoDelegate, BasicInfoDelegate, HeaderCellDelegate{
    
    func teamClicked() {
        self.segueToListing(viewSelection: .Teams)
    }
    
    func potClicked() {
        self.segueToListing(viewSelection: .Pots)
    }
    
    func whatsappClicked(){
        
        let model = detailVM.getSelectedModelWith()
        if let countryCode = model.admin_country_code, let phoneNumber = model.admin_phone {
            let phone = "+\(countryCode) \(phoneNumber)"
            let whatsappURLString = "whatsapp://send?phone=\(phone)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            if let urlString = whatsappURLString,
               let whatsappURL = URL(string: urlString),
               UIApplication.shared.canOpenURL(whatsappURL) {
                UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
            } else {
                self.showUpdateWith(msg: "Install whatsapp on this device to continue")
            }
            
        }

    }
    
    func leaveJoinClicked() {
        
        let model = self.detailVM.getSelectedModelWith()
        self.detailVM.delegate = self
        if model.already_joined == 1{
            self.detailVM.callLeaveAPI(tournamentID: self.tournamentID!)
        }else{
            self.detailVM.callJoinAPI(tournamentID: self.tournamentID!)
        }
        
    }
    
    func fixtureClicked() {
        
        let model = self.detailVM.getSelectedModelWith()
        if model.current_round_no == nil{
            self.showUpdateWith(msg: "Fixture not available")
        }else{
            let vc = FixtureVC.loadFromNib()
            vc.roundNo = model.current_round_no
            vc.roundName = model.current_round_name
            vc.tournamentID = model.tournament_details.tournament_id
            vc.isIndividual = self.isIndividual
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func signUpCaptainClicked() {
        let alertVC = UIAlertController(
            title: "Sign up as captain",
            message: "",
            preferredStyle: .alert
        )
        alertVC.addTextField()
        
        let yesAction = UIAlertAction(
            title: "SIGN UP", style: .default
        ) { [weak self] action in
            
            let answer = alertVC.textFields![0].text ?? ""
            
            if (answer.count > 0) {
                self?.detailVM.addTournamentTeamAPI(teamName: answer, tournamentID: (self?.tournamentID)!)
            }
            
        }
        
        let noAction = UIAlertAction(
            title: "Cancel", style: .cancel
        ) { action in
            
        }
        
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        self.present(alertVC, animated: true)
    }
    
    func removeAsCaptainClicked() {
        self.detailVM.removeAsCaptainAPI(tournamentID: (self.tournamentID)!)
    }
    
    
}

//MARK: Segue Actions
extension TournamentDetailVC{
    
    fileprivate func segueToListing(viewSelection: ListingView){
        
        let model = self.detailVM.getSelectedModelWith()
        let vc = ListingVC.loadFromNib()
        vc.tournamentID = model.tournament_details.tournament_id
        vc.listingView = viewSelection
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
