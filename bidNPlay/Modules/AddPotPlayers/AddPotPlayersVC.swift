//
//  AddPotPlayersVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 25/02/26.
//

import UIKit

class AddPotPlayersVC: BaseVC {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    internal var tournamentID : Int?
    internal var potID : Int?
    
    private let viewModel = AddPotPlayersVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBackButton()
        
        tableView.backgroundColor = CustomColor.bg
        searchBar.backgroundColor = CustomColor.bg
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Name or Phone"
        
        tableView.isEditing = true
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsSelectionDuringEditing = true
        
        viewModel.delegate = self
        
        
        
        if let tournamentID {
            self.viewModel.getNonPotPlayerList(tournamentID: tournamentID)
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

// MARK: IBAction UIButton
extension AddPotPlayersVC {    
    @IBAction func addPlayersAction(_ sender: UIButton) {
        if !viewModel.selectedPlayers.isEmpty, let potID {
            viewModel.addPlayersToPot(potID: potID)
        } else {
            showAlertWith(msg: "Please select a player to add.")
        }
    }
    
}

// MARK: UITableViewDataSource
extension AddPotPlayersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.response?.players.count ?? 0
        return viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "PlayerCell")
        
        let player = viewModel.searchResults[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "\(player.playerName) - \(player.playerPhone)"
        content.secondaryText = "M - \(player.noOfMatches), W - \(player.noOfWins), L - \(player.noOfLosses) D - \(player.noOfDraws)"
        cell.contentConfiguration = content
        cell.setSelected(viewModel.selectedPlayers.contains(player.userId), animated: false)
        cell.backgroundColor = CustomColor.bg2
        cell.contentView.backgroundColor = CustomColor.bg2
        return cell
    }
}

// MARK: UITableViewDelegate
extension AddPotPlayersVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = viewModel.searchResults[indexPath.row]
        viewModel.selectedPlayers.insert(player.userId)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let player = viewModel.searchResults[indexPath.row]
        viewModel.selectedPlayers.remove(player.userId)
        
    }
}

// MARK: UISearchBarDelegate
extension AddPotPlayersVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let indexes = viewModel.searchData(searchText)
        tableView.reloadData()
        for i in indexes {
            tableView.selectRow(at: .init(row: i, section: 0), animated: false, scrollPosition: .none)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.endEditing(true)
    }
}

// MARK: AddPotDelegate
extension AddPotPlayersVC: AddPotDelegate {
//    func potPlayersAdded() {
//        DispatchQueue.main.async {
//            if let tournamentID = self.tournamentID {
//                self.viewModel.getNonPotPlayerList(tournamentID: tournamentID)
//            }
//        }
//    }
    
    func refreshList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            ActivityHUD().dismissProgressHUD()
        }
        
    }
}
