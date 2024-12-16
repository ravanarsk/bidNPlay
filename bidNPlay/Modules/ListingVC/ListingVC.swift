//
//  ListingVC.swift
//  bidNPlay
//
//  Created by Ashin Asok on 16/12/24.
//

import UIKit

class ListingVC: BaseVC {

    @IBOutlet weak var listTableView: UITableView!
    
    internal var listingView : ListingView?
    internal var tournamentID : Int?
    internal var teamID : Int?
    internal var potID : Int?
    fileprivate var listingVM = ListingVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
    }

}

//MARK: Configure View
extension ListingVC{
    
    fileprivate func configureView(){
        
        self.listTableView.backgroundColor = CustomColor.bg
        self.listTableView.registerCells(names: [
            "ListingCell","EmptyListCell"
        ])
        self.listTableView.tableFooterView = UIView()
        self.listTableView.separatorStyle = .none
        self.listTableView.showsVerticalScrollIndicator = false
        self.listTableView.showsHorizontalScrollIndicator = false
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
    }
    
    fileprivate func setupView(){
        
        self.listingVM.listingView = self.listingView
        self.setNavigation()
        self.listingVM.delegate = self
        self.callAPI()
        
    }
    
    fileprivate func callAPI(){
        
        if self.listingView == .Players{
            self.listingVM.getPlayersList(tournamentID: self.tournamentID!)
        }else if self.listingView == .Teams{
            self.listingVM.getTeamList(tournamentID: self.tournamentID!)
        }else if self.listingView == .TeamPlayers{
            self.listingVM.getTeamPlayerList(teamID: self.teamID!)
        }else if self.listingView == .Pots{
            self.listingVM.getPotList(tournamentID: self.tournamentID!)
        }else if self.listingView == .PotPlayer{
            self.listingVM.getPotPlayerList(potID: self.potID!)
        }
        
    }
    
    fileprivate func setNavigation(){
        
        self.navigationController?.navigationBar.isOpaque = true
        self.setBackButton()
        if self.listingView == .Players{
            self.navigationItem.title = "Players List"
        }else if self.listingView == .Teams{
            self.navigationItem.title = "Team List"
        }else if self.listingView == .Pots{
            self.navigationItem.title = "Pot List"
        }else if self.listingView == .TeamPlayers{
            self.navigationItem.title = "Team Player List"
        }else if self.listingView == .PotPlayer{
            self.navigationItem.title = "Pot Player List"
        }
        
    }
    
}

//MARK: Tableview delegates
extension ListingVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listingVM.getRowCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.listingVM.isEmpty() == true{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyListCell", for: indexPath) as! EmptyListCell
            cell.messageLabel.text = "List Empty"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
            if self.listingView == .Players{
                let player = self.listingVM.getPlayerModel(index: indexPath.row)
                cell.setPlayerCell(player: player)
            }else if self.listingView == .Teams{
                let team = self.listingVM.getTeamModel(index: indexPath.row)
                cell.setTeamCell(team: team)
            }else if self.listingView == .TeamPlayers{
                let teamPlayer = self.listingVM.getTeamPlayerModel(index: indexPath.row)
                cell.setTeamPlayerCell(player: teamPlayer)
            }else if self.listingView == .Pots{
                let pot = self.listingVM.getPotModel(index: indexPath.row)
                cell.setPotCell(pot: pot)
            }else if self.listingView == .PotPlayer{
                let potPlayer = self.listingVM.getPotPlayerModel(index: indexPath.row)
                cell.setPotPlayerCell(player: potPlayer)
            }
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.listingVM.isEmpty() == true{
            return self.listTableView.frame.height
        }else{
            return 120
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.listingView == .Teams{
            let vc = ListingVC.loadFromNib()
            vc.listingView = .TeamPlayers
            let model = self.listingVM.getTeamModel(index: indexPath.row)
            vc.teamID = model.teamID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if self.listingView == .Pots{
            let vc = ListingVC.loadFromNib()
            vc.listingView = .PotPlayer
            let model = self.listingVM.getPotModel(index: indexPath.row)
            vc.potID = model.potID
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

//MARK: View Model Delegates
extension ListingVC: ListingDelegate{
    
    func modelUpdated() {
        
        DispatchQueue.main.async {
            
            ActivityHUD().dismissProgressHUD()
            self.listTableView.reloadData()
            
        }
        
    }
    
}
