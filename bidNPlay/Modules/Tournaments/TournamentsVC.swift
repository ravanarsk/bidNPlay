//
//  TournamentsVC.swift
//  bidNPlay
//
//  Created by SectorQube Tech Mini on 04/12/24.
//

import UIKit

class TournamentsVC: BaseVC {

    @IBOutlet weak var tournamentSegment: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    
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
    
        self.tournamentSegment.setTitle("My Tournaments", forSegmentAt: 0)
        self.tournamentSegment.setTitle("All Tournaments", forSegmentAt: 1)
        self.listTableView.backgroundColor = CustomColor.bg
        self.listTableView.registerCells(names: ["TournamentCell"])
        self.listTableView.dataSource = self
        self.listTableView.delegate = self
        self.listTableView.tableFooterView = UIView()
        self.listTableView.separatorStyle = .none
        
    }
    
    fileprivate func setUpVC(){
        
        self.navigationItem.title = "Tournaments"
        
        
    }
    
}

//MARK: Tableview delegates
extension TournamentsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TournamentCell", for: indexPath) as! TournamentCell
        cell.setupCell(index: indexPath.row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
