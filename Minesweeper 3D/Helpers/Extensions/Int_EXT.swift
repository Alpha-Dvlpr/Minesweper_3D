//
//  Int_EXT.swift
//  Minesweeper 3D
//
//  Created by Aaron on 9/7/21.
//

import Foundation

extension Int {
    
    static func ^ (radix: Int, power: Int) -> Int {
        return Int(pow(Double(radix), Double(power)))
    }
}
