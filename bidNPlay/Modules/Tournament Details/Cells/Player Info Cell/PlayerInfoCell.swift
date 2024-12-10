//
//  PlayerInfoCell.swift
//  bidNPlay
//
//  Created by Ashin Asok on 10/12/24.
//

import UIKit

class PlayerInfoCell: UITableViewCell {

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var playersTitle: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Configure cell
extension PlayerInfoCell{
    
    internal func configureCell(){
        
        self.holderView.layer.cornerRadius = 10
        self.holderView.backgroundColor = CustomColor.cellBg
        
        self.subTitleLabel.textColor = .black
        self.subTitleLabel.font = UIFont().mediumFontWith(size: 12)
        self.subTitleLabel.text = "VIEW"
        
        self.visualEffectView.layer.cornerRadius = 10
        self.visualEffectView.layer.masksToBounds = true
        self.visualEffectView.clipsToBounds = true
        
        self.arrowImage.tintColor = CustomColor.text
        self.arrowImage.image = UIImage(
            systemName: "arrow.right.square"
        )
        
        self.playerImage.tintColor = .black
        self.playerImage.image = UIImage(systemName: "person.circle")
        
        self.progressView.tintColor = .black
        self.progressView.trackTintColor = CustomColor.text
        
        self.totalLabel.textColor = .black
        self.totalLabel.font = UIFont().mediumFontWith(size: 12)
        
    }
    
}

//MARK: Set up cell
extension PlayerInfoCell{
    
    internal func setupCell(model: TournamentDetailModel){
        
        guard let maxPlayers = model.tournament_details.tournament_max_players else{
            self.totalLabel.text = ""
            return
        }
        let playerCount = model.tournament_details.players.count
        self.totalLabel.text = "Total: \(playerCount)/\(maxPlayers)"
        let progress = Float((playerCount-1))/Float(maxPlayers)
        debugPrint(progress)
        self.progressView.setProgress(progress, animated: true)
        
    }
    
}
