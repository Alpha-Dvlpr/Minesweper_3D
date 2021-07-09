//
//  Constants.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import SwiftUI

class Constants {
    
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
        
        let marginalWidth: Int = Int(UIScreen.main.bounds.size.width - margins)
        let totalItems: Int = Constants.numberOfItems + 2
        
        return CGFloat(marginalWidth / totalItems)
    }
}
