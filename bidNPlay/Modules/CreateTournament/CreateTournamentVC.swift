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
    @IBOutlet var txtDescription: UITextView!
    @IBOutlet var txtPlayerCount: UITextField!
    @IBOutlet var txtTeamCount: UITextField!
    @IBOutlet var isPrivate: UISwitch!
    
    @IBOutlet var stackPlayerCount: UIStackView!
    @IBOutlet var stackTeamCount: UIStackView!

    private var tournamentType: String = "team"
    private var fixtureType: String = "league"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setBackButton()
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
            switch action.identifier.rawValue {
            case "team":
                debugPrint("Team")
            case "individual":
                debugPrint("Individual")
            case "teamAuction":
                debugPrint("Team Auction")
            default:
                debugPrint("Not in Menu")
            }
            
            self?.tournamentType = action.identifier.rawValue
            self?.handleViewVisibilityBasedOnMenu()
        }
        
        let team = UIAction(title: "Team", identifier: UIAction.Identifier("team"), state: .on, handler: handler)
           let individual = UIAction(title: "Individual", identifier: UIAction.Identifier("individual"), handler: handler)
           let teamWithAuction = UIAction(title: "Team - with auction", identifier: UIAction.Identifier("teamAuction"), handler: handler)

           btnTournamentType.menu = UIMenu(children: [team, individual, teamWithAuction])
           btnTournamentType.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            btnTournamentType.changesSelectionAsPrimaryAction = true
        }

    }
    
    private func loadFixtureTypeMenu() {
        
        let handler: UIActionHandler = { [weak self] action in
            switch action.identifier.rawValue {
            case "league":
                debugPrint("league")
            case "knockout":
                debugPrint("knockout")
            default:
                debugPrint("Not in Menu")
            }
            
            self?.fixtureType = action.identifier.rawValue
            self?.handleViewVisibilityBasedOnMenu()
        }
        
        let league = UIAction(title: "League", identifier: UIAction.Identifier("league"), state: .on, handler: handler)
           let knockout = UIAction(title: "Knockout", identifier: UIAction.Identifier("knockout"), handler: handler)

        btnFixtureType.menu = UIMenu(children: [league, knockout])
        btnFixtureType.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            btnFixtureType.changesSelectionAsPrimaryAction = true
        }

    }
    
    private func loadPlayerCountMenu() {
        
        let handler: UIActionHandler = { action in
            switch action.identifier.rawValue {
            case "2":
                debugPrint("2")
            case "4":
                debugPrint("4")
            case "8":
                debugPrint("8")
            case "16":
                debugPrint("16")
            case "32":
                debugPrint("32")
            case "64":
                debugPrint("64")
            case "128":
                debugPrint("128")
            default:
                debugPrint("Not in Menu")
            }
        }
        
        
        var children: [UIAction] = []
        for i in ["2","4","8","16","32","64","128"] {
            let action = UIAction(title: i, identifier: UIAction.Identifier(i), handler: handler)
            children.append(action)
        }

        btnPlayerCount.menu = UIMenu(children: children)
        btnPlayerCount.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            btnPlayerCount.changesSelectionAsPrimaryAction = true
        }

    }
    
    private func loadTeamCountMenu() {
        
        let handler: UIActionHandler = { action in
            switch action.identifier.rawValue {
            case "2":
                debugPrint("2")
            case "4":
                debugPrint("4")
            case "8":
                debugPrint("8")
            case "16":
                debugPrint("16")
            case "32":
                debugPrint("32")
            case "64":
                debugPrint("64")
            case "128":
                debugPrint("128")
            default:
                debugPrint("Not in Menu")
            }
        }
        
        
        var children: [UIAction] = []
        for i in ["2","4","8","16","32","64","128"] {
            let action = UIAction(title: i, identifier: UIAction.Identifier(i), handler: handler)
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
        case "team", "teamAuction":
            debugPrint("Team")
            txtPlayerCount.isHidden = true
            stackPlayerCount.isHidden = true
            
        case "individual":
            debugPrint("Individual")
            txtTeamCount.isHidden = true
            stackTeamCount.isHidden = true
            
        default:
            debugPrint("Not in Menu")
        }
        
        switch fixtureType {
        case "league":
            debugPrint("league")
            stackPlayerCount.isHidden = true
            stackTeamCount.isHidden = true
        case "knockout":
            debugPrint("knockout")
            txtPlayerCount.isHidden = true
            txtTeamCount.isHidden = true
        default:
            debugPrint("Not in Menu")
        }
        
        
        
    }
}
