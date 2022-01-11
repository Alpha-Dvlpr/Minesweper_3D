//
//  Constants.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import SwiftUI

class Constants {
    
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    static let numberOfItems: Int = 10
    static let edge: CGFloat = 16
    static let cellSpacing: CGFloat = 1
    static let boardSpacing: CGFloat = 5
    static let boardCells = (0..<Constants.numberOfItems)
    static var numberOfMinesPerFace: Int { return (Constants.numberOfItems ^ 2) * 20 / 100 }
    static var cellSide: CGFloat {
        let innerBoardWidth: CGFloat = (CGFloat(Constants.numberOfItems) * Constants.cellSpacing)
        let edgeWidth: CGFloat = (2 * Constants.edge)
        let hintsSpacing: CGFloat = (2 * Constants.boardSpacing)
        
        let margins: CGFloat = hintsSpacing + edgeWidth + innerBoardWidth
        
        let marginalWidth: Int = Int(Constants.screenWidth - margins)
        let totalItems: Int = Constants.numberOfItems + 2
        
        return CGFloat(marginalWidth / totalItems)
    }
    static var numberOfHints: Int { return 2 }
    static var maxRanksRange = 10...30
}
