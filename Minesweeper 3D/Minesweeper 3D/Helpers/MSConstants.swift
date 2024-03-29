//
//  MSConstants.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI

class MSConstants {
    
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let maxRanksRange = 10...30
    static let cellSpacing: CGFloat = 1
    static let boardSpacing: CGFloat = 5
    static let edge: CGFloat = 16
    static let numberOfItems: Int = 10
    static var cellSide: CGFloat {
        let innerBoardWidth: CGFloat = (CGFloat(numberOfItems) * cellSpacing)
        let edgeWidth: CGFloat = (2 * edge)
        let hintsSpacing: CGFloat = (2 * boardSpacing)
        let margins: CGFloat = hintsSpacing + edgeWidth + innerBoardWidth
        let marginalWidth: Int = Int(screenWidth - margins)
        let totalItems: Int = numberOfItems + 2
        
        return CGFloat(marginalWidth / totalItems)
    }
}
