//
//  TournamentCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 04/12/24.
//

import UIKit

class TournamentCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var matchTitle: UILabel!
    @IBOutlet weak var matchCode: UILabel!
    @IBOutlet weak var ownerTitle: UILabel!
    @IBOutlet weak var winnerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Init View
extension TournamentCell{
    
    fileprivate func configureCell(){
        
        self.holderView.backgroundColor = CustomColor.bg2
        self.holderView.layer.cornerRadius = 10
        self.matchTitle.textColor = CustomColor.text
        self.matchCode.textColor = CustomColor.text2
        self.ownerTitle.textColor = CustomColor.text3
        self.winnerTitle.textColor = CustomColor.text4
        self.ownerTitle.text = "Owner"
        
    }
    
}

//MARK: Setup cell
extension TournamentCell{
    
    internal func setupCell(model: TournamentListDetailModel, user_id: Int){
        
        if let tournament_creator_id = model.user_id{
            if tournament_creator_id == user_id{
                self.ownerTitle.isHidden = false
            }else{
                self.ownerTitle.isHidden = true
            }
        }else{
            self.ownerTitle.isHidden = true
        }
        
        if let winner_team_name = model.winner_team_name{
            self.winnerTitle.isHidden = false
            self.winnerTitle.text = "Winner Team : \(winner_team_name.capitalized)"
        }else if let winner_user_name = model.winner_user_name{
            self.winnerTitle.isHidden = false
            self.winnerTitle.text = "Winner : \(winner_user_name.capitalized)"
        }else{
            self.winnerTitle.isHidden = false
            self.winnerTitle.text = "Ongoing"
        }
        
        self.matchTitle.text = (model.tournament_title ?? "").capitalized
        self.matchCode.text = model.tournament_code
        
    }
    
}
