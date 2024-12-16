//
//  ListingCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 16/12/24.
//

import UIKit

class ListingCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var holderStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Configure Cell
extension ListingCell{
    
    fileprivate func configureCell(){
        
        self.holderView.backgroundColor = CustomColor.bg2
        self.holderView.layer.cornerRadius = 10
        self.titleLabel.textColor = CustomColor.text
        self.titleLabel.font = UIFont().mediumFontWith(size: 16)
        self.subTitleLabel.textColor = CustomColor.text2
        self.subTitleLabel.font = UIFont().regularFontWith(size: 14)
        
        self.visualEffectView.layer.cornerRadius = 10
        self.visualEffectView.layer.masksToBounds = true
        self.visualEffectView.clipsToBounds = true
        
        self.arrowImage.tintColor = CustomColor.text
        self.arrowImage.image = UIImage(
            systemName: "arrow.right.square"
        )
        
    }
    
}

//MARK: Setup Cell
extension ListingCell{
    
    internal func setPlayerCell(player: Player){
        
        self.titleLabel.text = player.playerName?.capitalized
        self.subTitleLabel.text = "+" + player.playerCountryCode + " " + player.playerPhone
        self.visualEffectView.isHidden = true
        self.arrowView.isHidden = true
        
    }
    
    internal func setTeamCell(team: Team){
        
        self.titleLabel.text = team.teamName.capitalized
        self.subTitleLabel.text = "Captain : " + (team.captainUserName ?? "").capitalized
        self.visualEffectView.isHidden = false
        self.arrowView.isHidden = false
        
    }
    
    internal func setTeamPlayerCell(player: TeamPlayer){
        
        if player.isCaptain == 1{
            self.titleLabel.text = (player.playerName ?? "").capitalized + " (C)"
        }else if player.isViceCaptain == 1{
            self.titleLabel.text = (player.playerName ?? "").capitalized + " (VC)"
        }else{
            self.titleLabel.text = (player.playerName ?? "").capitalized
        }
        self.subTitleLabel.text = "+" + player.playerCountryCode + " " + player.playerPhone
        self.visualEffectView.isHidden = true
        self.arrowView.isHidden = true
        
    }
    
    internal func setPotCell(pot: Pot){
        
        self.titleLabel.text = pot.potName.capitalized
        self.subTitleLabel.text = "Base Price : \(pot.basePrice)"
        self.visualEffectView.isHidden = false
        self.arrowView.isHidden = false
        
    }
    
    internal func setPotPlayerCell(player: PotPlayer){
        
        self.titleLabel.text = player.playerName.capitalized
        self.subTitleLabel.text = "\((player.teamName ?? "").capitalized) - \((player.soldStatus ?? "").capitalized)"
        self.visualEffectView.isHidden = true
        self.arrowView.isHidden = true
        
    }
    
}
