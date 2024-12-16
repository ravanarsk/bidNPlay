//
//  TeamInfoCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 10/12/24.
//

import UIKit

protocol TeamInfoDelegate {
    
    func teamClicked()
    func potClicked()
    
}

class TeamInfoCell: UITableViewCell {

    @IBOutlet weak var teamVisualEffect: UIVisualEffectView!
    @IBOutlet weak var potVisualEffect: UIVisualEffectView!
    @IBOutlet weak var teamHolderView: UIView!
    @IBOutlet weak var teamIcon: UIImageView!
    @IBOutlet weak var teamTitle: UILabel!
    @IBOutlet weak var teamSubTitle: UILabel!
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var teamArrow: UIImageView!
    @IBOutlet weak var potHolderView: UIView!
    @IBOutlet weak var potIcon: UIImageView!
    @IBOutlet weak var potTitle: UILabel!
    @IBOutlet weak var potSubTitle: UILabel!
    @IBOutlet weak var potButton: UIButton!
    @IBOutlet weak var potArrow: UIImageView!
    
    internal var delegate : TeamInfoDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Configure Cell
extension TeamInfoCell{
    
    private func configureCell(){
        
        self.teamTitle.text = "Teams"
        self.teamTitle.textColor = .black
        self.teamTitle.font = UIFont().mediumFontWith(size: 20)
        
        self.potTitle.text = "Pots"
        self.potTitle.textColor = .black
        self.potTitle.font = UIFont().mediumFontWith(size: 20)
        
        self.teamSubTitle.textColor = .black
        self.teamSubTitle.font = UIFont().regularFontWith(size: 12)
        
        self.potSubTitle.textColor = .black
        self.potSubTitle.font = UIFont().regularFontWith(size: 12)
        
        self.teamArrow.tintColor = CustomColor.text
        self.teamArrow.image = UIImage(
            systemName: "arrow.right.square"
        )
        
        self.potArrow.tintColor = CustomColor.text
        self.potArrow.image = UIImage(
            systemName: "arrow.right.square"
        )
        
        self.teamIcon.tintColor = CustomColor.text
        self.teamIcon.image = UIImage(
            systemName: "person.2.circle"
        )
        
        self.potIcon.tintColor = CustomColor.text
        self.potIcon.image = UIImage(
            systemName: "person.bust.circle"
        )
        
        self.teamHolderView.backgroundColor = CustomColor.cellBg2
        self.teamHolderView.layer.cornerRadius = 10
        
        self.potHolderView.backgroundColor = CustomColor.cellBg3
        self.potHolderView.layer.cornerRadius = 10
        
        self.teamSubTitle.text = "Click here to view and create teams."
        self.potSubTitle.text = "Click here to view and create pots."
        
        self.teamVisualEffect.layer.cornerRadius = 10
        self.teamVisualEffect.layer.masksToBounds = true
        self.teamVisualEffect.clipsToBounds = true
        
        self.potVisualEffect.layer.cornerRadius = 10
        self.potVisualEffect.layer.masksToBounds = true
        self.potVisualEffect.clipsToBounds = true
        
        self.teamButton.addTarget(self, action: #selector(teamAction), for: .touchUpInside)
        self.potButton.addTarget(self, action: #selector(potAction), for: .touchUpInside)
        
    }
    
}

//MARK: Set Cell
extension TeamInfoCell{
    
    internal func setCell(model: TournamentDetailModel){
        
        if model.tournament_details.tournament_type == "Team_woa"{
            self.potHolderView.isHidden = true
            self.potVisualEffect.isHidden = true
        }else{
            self.potHolderView.isHidden = false
            self.potVisualEffect.isHidden = false
        }
        
    }
    
}

//MARK: Button Actions
extension TeamInfoCell{
    
    @objc fileprivate func teamAction(){
        self.delegate?.teamClicked()
    }
    
    @objc fileprivate func potAction(){
        self.delegate?.potClicked()
    }
    
}
