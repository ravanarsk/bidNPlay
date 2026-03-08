//
//  StringExt.swift
//  bidNPlay
//
//  Created by Saravana Kumar on 06/03/26.
//

import Foundation

extension String {
    func trim() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
