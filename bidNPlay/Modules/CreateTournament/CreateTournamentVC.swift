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
    
//    private var selectedPlayerCount = ""
//    private var selectedTeamCount = ""
    
    private var teamCount: String = ""
    private var playerCount: String = ""
    
    private var viewModel = CreateTournamentVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.delegate = self
        
        self.setBackButton()
        self.navigationItem.title = "Create Tournament"
        loadTournamentTypeMenu()
        loadFixtureTypeMenu()
        loadPlayerCountMenu()
        loadTeamCountMenu()
        handleViewVisibilityBasedOnMenu()
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
            
            self?.playerCount = action.identifier.rawValue
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
            self?.teamCount = action.identifier.rawValue
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
        
        stackPlayerCountTXT.isHidden = true
        stackPlayerCount.isHidden = true
        stackTeamCountTXT.isHidden = true
        stackTeamCount.isHidden = true
        
        switch tournamentType {
        case  .team, .teamWithAuction:
            switch fixtureType {
            case .league:
                stackPlayerCountTXT.isHidden = false
                stackTeamCountTXT.isHidden = false

            case .knockout:
                stackPlayerCountTXT.isHidden = false
                stackTeamCount.isHidden = false
            }
            
        case .individual:
            switch fixtureType {
            case .league:
                stackPlayerCountTXT.isHidden = false
            case .knockout:
                stackPlayerCount.isHidden = false
            }
        }
        
        
        
    }
    
    @IBAction func createAction(_ sender: UIButton) {
        
//        debugPrint(selectedTeamCount)
//        debugPrint(selectedPlayerCount)
        
//        return
        
        if validateForm() {
            viewModel.createTournamentAPI(title: txtTitle.text!,
                                          desc: txtDescription.text!,
                                          tournamentType: tournamentType.rawValue,
                                          fixtureType: fixtureType.rawValue,
                                          playerCount: playerCount,
                                          teamCount: teamCount,
                                          isPrivate: isPrivate.isOn)
        }
    }
}

// MARK: API
extension CreateTournamentVC {
    
    private func validateForm() -> Bool {
        
        var flag = true
        
        
        let title = txtTitle.text!
        let desc = txtDescription.text!
        
        
        
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorTitle.isHidden = false
            flag = false
        } else {
            errorTitle.isHidden = true
        }
        
        if desc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorDescription.isHidden = false
            flag = false
        } else {
            errorDescription.isHidden = true
        }
        
        switch tournamentType {
        case  .team, .teamWithAuction:
            switch fixtureType {
            case .league:
                playerCount = txtPlayerCount.text ?? ""
                teamCount = txtTeamCount.text ?? ""
            case .knockout:
                playerCount = txtPlayerCount.text ?? ""
                teamCount = btnTeamCount.titleLabel?.text ?? ""
            }
        case .individual:
            switch fixtureType {
            case .league:
                playerCount = txtPlayerCount.text ?? ""
            case .knockout:
                playerCount = btnPlayerCount.titleLabel?.text ?? ""
            }
            teamCount = "0"
        }
        
        if playerCount.trimmingCharacters(in: .init(charactersIn: "0123456789").inverted).isEmpty {
            errorPlayerCount.isHidden = false
            flag = false
        } else {
            errorPlayerCount.isHidden = true
        }
        
        if teamCount.trimmingCharacters(in: .init(charactersIn: "0123456789").inverted).isEmpty {
            errorTeamCount.isHidden = false
            flag = false
        } else {
            errorTeamCount.isHidden = true
        }
        
        return flag
    }
}

// MARK: CreateTournamentDelegate
extension CreateTournamentVC: CreateTournamentDelegate {
    func tournamentCreated(_ response: CreateTournamentResponse) {
        DispatchQueue.main.async { [weak self] in
            ActivityHUD().dismissProgressHUD()
            if response.status ?? false {
                self?.popSuccessAlertWith(msg: response.message ?? "")
            } else {
                self?.showAlertWith(msg: response.message ?? "")
            }
        }
    }
}
