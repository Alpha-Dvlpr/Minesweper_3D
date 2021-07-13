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
    
    static func opposite(of number: Int, max: Int) -> Int {
        guard number <= max else { return max }
        
        return max - number
    }
    
    static func random(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
}
