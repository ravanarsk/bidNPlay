//
//  PlayerStatsCell.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 10/03/25.
//

import UIKit

class PlayerStatsCell: UITableViewCell {
    
    @IBOutlet var viewContainer: UIView!
    
    @IBOutlet var lblPos: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblMP: UILabel!
    @IBOutlet var lblW: UILabel!
    @IBOutlet var lblD: UILabel!
    @IBOutlet var lblL: UILabel!
    @IBOutlet var lblPlusMinus: UILabel!
    @IBOutlet var lblGD: UILabel!
    @IBOutlet var lblPts: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewContainer.backgroundColor = CustomColor.bg
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func setPlayerStat(position: Int, model: PlayerStats) {
        lblPos.text = "\(position)"
        lblName.text = model.playerName
        lblMP.text = "\(model.noOfMatches)"
        lblW.text = "\(model.noOfWins)"
        lblD.text = "\(model.noOfDraws)"
        lblL.text = "\(model.noOfLosses)"
        lblPlusMinus.text = "\(model.goalsForward)-\(model.goalsAgainst)"
        lblGD.text = "\(model.goalsDifference)"
        lblPts.text = "\(model.winPercentage)"
    }
}
