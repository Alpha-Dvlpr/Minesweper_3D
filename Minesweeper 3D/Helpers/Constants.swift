//
//  Constants.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import SwiftUI

class Constants {
    
    static var numberOfItems: Int = 10
    static var edge: CGFloat = 16
    static var cellSpacing: CGFloat = 1
    static var boardSpacing: CGFloat = 10
    static var boardCells: ClosedRange = (1...Constants.numberOfItems)
    static var cellSide: CGFloat {
        let innerBoardWidth: CGFloat = (CGFloat(Constants.numberOfItems) * Constants.cellSpacing)
        let edgeWidth: CGFloat = (2 * Constants.edge)
        let hintsSpacing: CGFloat = (2 * Constants.boardSpacing)
        
        let margins: CGFloat = hintsSpacing + edgeWidth + innerBoardWidth
        
        let marginalWidth: Int = Int(UIScreen.main.bounds.size.width - margins)
        let totalItems: Int = Constants.numberOfItems + 2
        
        return CGFloat(marginalWidth / totalItems)
    }
}
