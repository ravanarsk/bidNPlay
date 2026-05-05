//
//  SoldPlayersVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 22/04/26.
//

import UIKit

class SoldPlayersVC: BaseVC {
    
    @IBOutlet var tableView: UITableView!
    
    var viewConfig: SoldPlayersViewConfig = .soldPlayers
    var tournamentID: Int?
    
    private var viewModel: SoldPlayersVM = SoldPlayersVM()
    
    
    enum SoldPlayersViewConfig {
        case soldPlayers
        case teamBidBalance
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setBackButton()
        switch viewConfig {
        case .soldPlayers:
            self.navigationItem.title = "Sold Players"
        case .teamBidBalance:
            self.navigationItem.title = "Bid Balance"
        }
        
        self.view.backgroundColor = CustomColor.bg
        
        viewModel.delegate = self
        setupTableview()
        if let tournamentID {
            switch viewConfig {
            case .soldPlayers:
                viewModel.callAuctionSoldPlayersAPI(tournamentID: tournamentID)
            case .teamBidBalance:
                viewModel.callTeamsBidBalanceAPI(tournamentID: tournamentID)
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SoldPlayersVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewConfig {
            
        case .soldPlayers:
            return viewModel.response?.players?.count ?? 0
        case .teamBidBalance:
            return viewModel.responseTeamBidBalanceResponse?.teams?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoldPlayersTableViewCell", for: indexPath) as! SoldPlayersTableViewCell
        
        switch viewConfig {
            
        case .soldPlayers:
            if let player = viewModel.getPlayer(at: indexPath.row) {
                cell.setData(player)
            }
        case .teamBidBalance:
            if let team = viewModel.responseTeamBidBalanceResponse?.teams?[indexPath.row] {
                cell.setData(team)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension SoldPlayersVC: SoldPlayersDelegate {
    
    func soldPlayerApiSuccess() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.tableView.reloadData()
        }
    }
    
    func teamBidBalanceApiSuccess() {
        DispatchQueue.main.async {
            ActivityHUD().dismissProgressHUD()
            self.tableView.reloadData()
        }
    }
}

private extension SoldPlayersVC {
    func setupTableview() {
        self.tableView.registerCells(names:[
            "SoldPlayersTableViewCell"
        ])
    }
}
