//
//  TableViewExt.swift
//  bidNPlay
//
//  Created by SectorQube Tech Mini on 04/12/24.
//

import UIKit

extension UITableView{
    
    func registerCells(names: [String]){
        
        for name in names{
            self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
            self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
        }
        
    }
    
}
