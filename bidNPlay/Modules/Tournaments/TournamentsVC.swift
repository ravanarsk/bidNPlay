//
//  TournamentsVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 04/12/24.
//

import UIKit

class TournamentsVC: BaseVC {

    @IBOutlet weak var tournamentSegment: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    
    fileprivate var tournamentVM = TournamentsVM()
    fileprivate var user_id : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpVC()
    }

}

//MARK: Init View
extension TournamentsVC{
    
    fileprivate func configureVC(){
    
        self.tournamentVM.delegate = self
        self.tournamentSegment.setTitle("My Tournaments", forSegmentAt: 0)
        self.tournamentSegment.setTitle("All Tournaments", forSegmentAt: 1)
        self.tournamentSegment.addTarget(
            self,
            action: #selector(segmentedControlValueChanged(_:)),
            for: .valueChanged
        )
        
        self.user_id = DefaultWrapper().getIntFrom(Key: Keys.userID)
        
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle"),
            style: .done,
            target: self,
            action: #selector(showJoinTournament)
        )
        barButtonItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = barButtonItem

        self.listTableView.backgroundColor = CustomColor.bg
        self.listTableView.registerCells(names: [
            "TournamentCell","EmptyListCell"
        ])
        self.listTableView.tableFooterView = UIView()
        self.listTableView.separatorStyle = .none
        self.listTableView.showsVerticalScrollIndicator = false
        self.listTableView.showsHorizontalScrollIndicator = false
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
    }
    
    fileprivate func setUpVC(){
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "Tournaments"
        self.tournamentSegment.selectedSegmentIndex = 0
        self.callListingAPI(segment: 0)
        
    }
    
}

//MARK: Actions
extension TournamentsVC{
    
    fileprivate func callListingAPI(segment: Int){
        
        self.tournamentVM.showTournamentListing(segment: segment)
        
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        self.callListingAPI(segment: sender.selectedSegmentIndex)
        
    }
    
    @objc fileprivate func showJoinTournament(){
        
        let vc = CustomTFAlertVC.loadFromNib()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        vc.titleForAlert = "Join Tournament"
        vc.subTitleForAlert = "Please enter your shared tournament code to join tournaments."
        self.present(vc, animated: true)
        
    }
    
}

//MARK: Tableview delegates
extension TournamentsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.tournamentVM.isEmpty() == true{
            return 1
        }else{
            return self.tournamentVM.getRowCount()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.tournamentVM.isEmpty() == true{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyListCell", for: indexPath) as! EmptyListCell
            cell.messageLabel.text = "No Tournaments"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TournamentCell", for: indexPath) as! TournamentCell
            let model = self.tournamentVM.getSelectedModelWith(index: indexPath.row)
            cell.setupCell(model: model, user_id: self.user_id)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.tournamentVM.isEmpty() == true{
            return self.listTableView.frame.height
        }else{
            return 150
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TournamentDetailVC.loadFromNib()
        let model = self.tournamentVM.getSelectedModelWith(index: indexPath.row)
        vc.tournamentID = model.tournament_id
        if model.tournament_type == "Individual"{
            vc.isIndividual = true
        }else{
            vc.isIndividual = false
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: View Model Delegates
extension TournamentsVC: TournamentsDelegate{
    
    func showTournaments() {
        
        DispatchQueue.main.async {
            
            ActivityHUD().dismissProgressHUD()
            self.listTableView.reloadData()
            
        }
        
    }
    
    func joinTournamentResponse(msg: String) {
        
        DispatchQueue.main.async {
            
            ActivityHUD().dismissProgressHUD()
            self.showUpdateWith(msg: msg)
            
        }
        
    }
    
}

//MARK: Custom Alert TF Delegates
extension TournamentsVC: CustomTFDelegate{
    
    func getTextfieldEntry(value: String) {
        
        debugPrint(value)
        self.tournamentVM.callJoinTournament(code: value)
        
    }
    
}
