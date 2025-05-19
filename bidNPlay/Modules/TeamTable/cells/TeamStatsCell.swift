//
//  TeamStatsCell.swift
//  bidNPlay
//
//  Created by Saravana Kumar K R on 21/03/25.
//

import UIKit

class TeamStatsCell: UITableViewCell {
    
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
 
    internal func setIndividualStat(position: Int, model: IndividualTableStat) {
        lblPos.text = "\(position)"
        lblName.text = model.userName
        lblMP.text = "\(model.noOfMatches)"
        lblW.text = "\(model.noOfWins)"
        lblD.text = "\(model.noOfDraws)"
        lblL.text = "\(model.noOfLosses)"
        lblPlusMinus.text = "\(model.goalsForward)-\(model.goalsAgainst)"
        lblGD.text = "\(model.goalsDifference)"
        lblPts.text = "\(model.points)"
    }
    
    internal func setTeamStat(position: Int, model: TeamTableStat) {
        lblPos.text = "\(position)"
        lblName.text = model.teamName
        lblMP.text = "\(model.noOfMatches)"
        lblW.text = "\(model.noOfWins)"
        lblD.text = "\(model.noOfDraws)"
        lblL.text = "\(model.noOfLosses)"
        lblPlusMinus.text = "\(model.goalsForward)-\(model.goalsAgainst)"
        lblGD.text = "\(model.goalsDifference)"
        lblPts.text = "\(model.points)"
    }
}
