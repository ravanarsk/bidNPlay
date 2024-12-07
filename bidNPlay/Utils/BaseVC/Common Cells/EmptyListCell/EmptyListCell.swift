//
//  EmptyListCell.swift
//  SmartLock-SQT
//
//  Created by SQT MAC PRO on 12/09/22.
//

import UIKit

class EmptyListCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Set up message for empty cell
extension EmptyListCell{
    
    internal func setUpMessage(msg : String){
        
        self.messageLabel.text = msg
        self.messageLabel.font = UIFont().mediumFontWith(size: 18)
        self.messageLabel.textColor = .lightGray
        
    }
    
}
