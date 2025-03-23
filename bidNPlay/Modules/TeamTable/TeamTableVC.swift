//
//  TeamTableVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 11/03/25.
//

import UIKit

class TeamTableVC: BaseVC {
    
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var tableView: UITableView!
    
    internal var tournamentID : Int!
    internal var isIndividual : Bool = false
    
    fileprivate var viewModel = TeamTableVM()
        
    

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
        
        viewModel.getTableStats()
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
extension TeamTableVC: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func registerCells() {
        tableView.registerCells(names: ["TeamStatsCell"])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isIndividual {
            return viewModel.individualResponse?.table.count ?? 0
        } else {
            return viewModel.teamResponse?.table.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamStatsCell", for: indexPath) as? TeamStatsCell else { return UITableViewCell()}
        if isIndividual {
            if let model = viewModel.individualResponse?.table[indexPath.row] {
                cell.setIndividualStat(position: indexPath.row + 1, model: model)
            }
        } else {
            if let model = viewModel.teamResponse?.table[indexPath.row] {
                cell.setTeamStat(position: indexPath.row + 1, model: model)
            }
        }
        return cell
    }
    
}

//MARK: TeamTableDelegate
extension TeamTableVC: TeamTableDelegate {
    func reloadTable() {
        DispatchQueue.main.async { [weak tableView] in
            ActivityHUD().dismissProgressHUD()
            tableView?.reloadData()
        }
    }
}

//MARK: API CALLs
extension TeamTableVC {
    
}
