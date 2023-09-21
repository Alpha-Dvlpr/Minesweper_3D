//
//  MSConstants.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import SwiftUI

class MSConstants {
    
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    static let numberOfItems: Int = 10
    static let edge: CGFloat = 16
    static let cellSpacing: CGFloat = 1
    static let boardSpacing: CGFloat = 5
    static let boardCells = (0..<numberOfItems)
    static var numberOfMinesPerFace: Int { return (numberOfItems ^ 2) * 20 / 100 } // TODO: Save difficulty on database to get percentage
    static var cellSide: CGFloat {
        let innerBoardWidth: CGFloat = (CGFloat(numberOfItems) * cellSpacing)
        let edgeWidth: CGFloat = (2 * edge)
        let hintsSpacing: CGFloat = (2 * boardSpacing)
        
        let margins: CGFloat = hintsSpacing + edgeWidth + innerBoardWidth
        
        let marginalWidth: Int = Int(screenWidth - margins)
        let totalItems: Int = numberOfItems + 2
        
        return CGFloat(marginalWidth / totalItems)
    }
    static var numberOfHints: Int { return 2 } // TODO: Save on database for future in-app purchases
    static var maxRanksRange = 10...30
}
