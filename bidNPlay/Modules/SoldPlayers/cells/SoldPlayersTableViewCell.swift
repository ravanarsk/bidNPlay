//
//  SoldPlayersTableViewCell.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 03/05/26.
//

import UIKit

class SoldPlayersTableViewCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblSoldAmt: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func setData(_ data: SoldPlayer) {
        lblName.text = "\(data.playerName ?? "") - \(data.teamName ?? "")"
        lblSoldAmt.text = "\(data.bidPriceInCr ?? 0) Cr"
    }
    
    internal func setData(_ data: AuctionTeamBalance) {
        lblName.text = "\(data.teamName ?? "") - \(data.captainName ?? "")"
        lblSoldAmt.text = "\(data.totalBidPriceInCr ?? 0) Cr"
    }
}
