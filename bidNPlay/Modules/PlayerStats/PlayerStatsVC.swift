//
//  PlayerStatsVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 10/03/25.
//

import UIKit

class PlayerStatsVC: BaseVC {
    
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var tableView: UITableView!
    
    internal var tournamentID : Int!
    internal var isIndividual : Bool = false
    
    fileprivate var viewModel = PlayerStatsVM()
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.registerCells()
        
        self.setBackButton()
        self.navigationItem.title = "Table Stats"
        self.viewHeader.backgroundColor  = CustomColor.bg
        self.tableView.backgroundColor = CustomColor.bg
        
        viewModel.delegate = self
        viewModel.tournamentID = tournamentID
        viewModel.isIndividual = isIndividual
        
        viewModel.getStats()
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


//MARK: UITableViewDelegate, UITableViewDataSource
extension PlayerStatsVC: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func registerCells() {
        tableView.registerCells(names: ["PlayerStatsCell"])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isIndividual {
            return viewModel.response?.table.count ?? 0
        } else {
            return viewModel.response?.table.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as? PlayerStatsCell else { return UITableViewCell()}
        
        if let model = viewModel.response?.table[indexPath.row] {
            cell.setPlayerStat(position: indexPath.row + 1, model: model)
        }
        
        return cell
    }
    
}

//MARK: TeamTableDelegate
extension PlayerStatsVC: PlayerStatsDelegate {
    func reloadTable() {
        DispatchQueue.main.async { [weak tableView] in
            ActivityHUD().dismissProgressHUD()
            tableView?.reloadData()
        }
    }
}
