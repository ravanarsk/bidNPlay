//
//  CreateTournamentVC.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 20/09/25.
//

import UIKit

class CreateTournamentVC: BaseVC {
    
    @IBOutlet var btnTournamentType: UIButton!
    @IBOutlet var btnFixtureType: UIButton!
    
    @IBOutlet var btnPlayerCount: UIButton!
    @IBOutlet var btnTeamCount: UIButton!
    
    @IBOutlet var txtTitle: UITextField!
    @IBOutlet var errorTitle: UILabel!
    
    @IBOutlet var txtDescription: UITextView!
    @IBOutlet var errorDescription: UILabel!
    
    @IBOutlet var txtPlayerCount: UITextField!
    @IBOutlet var errorPlayerCount: UILabel!
    
    @IBOutlet var txtTeamCount: UITextField!
    @IBOutlet var errorTeamCount: UILabel!
    
    @IBOutlet var isPrivate: UISwitch!
    
    @IBOutlet var stackPlayerCount: UIStackView!
    @IBOutlet var stackTeamCount: UIStackView!
    
    @IBOutlet var stackPlayerCountTXT: UIStackView!
    @IBOutlet var stackTeamCountTXT: UIStackView!

    private var tournamentType: TournamentType = .team
    private var fixtureType: FixtureType = .league
    
    private var selectedPlayerCount = ""
    private var selectedTeamCount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setBackButton()
        self.navigationItem.title = "Create Tournament"
        loadTournamentTypeMenu()
        loadFixtureTypeMenu()
        loadPlayerCountMenu()
        loadTeamCountMenu()
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

// MARK: IBAction UIButtion Menu
extension CreateTournamentVC {
    
    private func loadTournamentTypeMenu() {
        
        let handler: UIActionHandler = { [weak self] action in
            
            
            self?.tournamentType = .init(rawValue: action.identifier.rawValue) ?? .team
            self?.handleViewVisibilityBasedOnMenu()
        }
        
        var children = [UIAction]()
        for item in TournamentType.allCases {
            let action = UIAction(title: item.name,identifier: UIAction.Identifier( item.rawValue),  handler: handler)
            children.append(action)
        }
        
        btnTournamentType.menu = UIMenu(children: children)
        btnTournamentType.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            btnTournamentType.changesSelectionAsPrimaryAction = true
        }

    }
    
    private func loadFixtureTypeMenu() {
        
        let handler: UIActionHandler = { [weak self] action in
            self?.fixtureType = .init(rawValue: action.identifier.rawValue) ?? .league
            self?.handleViewVisibilityBasedOnMenu()
        }
        
        var children = [UIAction]()
        
        for item in FixtureType.allCases {
            let action = UIAction(title: item.name, identifier: UIAction.Identifier(item.rawValue), handler: handler)
            children.append(action)
        }

        btnFixtureType.menu = UIMenu(children: children)
        btnFixtureType.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            btnFixtureType.changesSelectionAsPrimaryAction = true
        }

    }
    
    private func loadPlayerCountMenu() {
        
        let handler: UIActionHandler = { [weak self]action in
            
            self?.selectedPlayerCount = action.identifier.rawValue
        }
        
        
        var children: [UIAction] = []
        for i in PlayerCount {
            let action = UIAction(title: "\(i)", identifier: UIAction.Identifier("\(i)"), handler: handler)
            children.append(action)
        }

        btnPlayerCount.menu = UIMenu(children: children)
        btnPlayerCount.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            btnPlayerCount.changesSelectionAsPrimaryAction = true
        }

    }
    
    private func loadTeamCountMenu() {
        
        let handler: UIActionHandler = { [weak self] action in
            self?.selectedTeamCount = action.identifier.rawValue
        }
        
        var children: [UIAction] = []
        for i in TeamCount {
            let action = UIAction(title: "\(i)", identifier: UIAction.Identifier("\(i)"), handler: handler)
            children.append(action)
        }

        btnTeamCount.menu = UIMenu(children: children)
        btnTeamCount.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            btnTeamCount.changesSelectionAsPrimaryAction = true
        }

    }
    
   
    private func handleViewVisibilityBasedOnMenu() {
        
        txtPlayerCount.isHidden = false
        stackPlayerCount.isHidden = false
        txtTeamCount.isHidden = false
        stackTeamCount.isHidden = false
        
        
        switch tournamentType {
            
        case  .team, .teamWithAuction:
            debugPrint("Team")
            txtPlayerCount.isHidden = true
            stackPlayerCount.isHidden = true
            
        case .individual:
            debugPrint("Individual")
            txtTeamCount.isHidden = true
            stackTeamCount.isHidden = true
        }
        
        switch fixtureType {
        case .league:
            debugPrint("league")
            stackPlayerCount.isHidden = true
            stackTeamCount.isHidden = true
        case .knockout:
            debugPrint("knockout")
            txtPlayerCount.isHidden = true
            txtTeamCount.isHidden = true
        }
        
    }
}

// MARK: API
extension CreateTournamentVC {
    
    func validateFormAndCreate() -> Bool {
        
        var flag = false
        
        
        guard let title = txtTitle.text, !title.isEmpty else {
//            showErrorMessage("Title is required")
            return false
        }
        
        guard let description = txtDescription.text, !description.isEmpty else {
            return false
        }
        
        let playerCount: String
        let teamCount: String
        
        switch tournamentType {
            
        case .team, .teamWithAuction:
            switch fixtureType {
                
            case .league:
                playerCount = txtPlayerCount.text ?? ""
                teamCount = txtTeamCount.text ?? ""
            case .knockout:
                playerCount = selectedPlayerCount
                teamCount = selectedTeamCount
            }
        case .individual:
            
            teamCount = ""
            switch fixtureType {
                
            case .league:
                playerCount = txtPlayerCount.text ?? ""
            case .knockout:
                playerCount = selectedPlayerCount
            }
        }
        
        guard let playerCount = Int(playerCount), playerCount > 0 else {
            return false
        }        
        
        
        return flag
    }
}
