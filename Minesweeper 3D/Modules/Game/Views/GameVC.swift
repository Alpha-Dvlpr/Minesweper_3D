//
//  GameVC.swift
//  Minesweeper 3D
//
//  Created by Aaron on 18/7/21.
//

import SwiftUI

struct GameVC: View {
    
    @State private var selectedCell: Cell = Cell.void
    @State private var actionsEnabled: Bool = false
    
    var sideFaces: BoardT_4?
    var visibleFace: Face?
    var gameStatus: GameStatus
    var rotateCallback: ((Direction) -> Void)
    var updateCallback: ((Cell) -> Void)
    
    var body: some View {
        if let sides = self.sideFaces, let visible = self.visibleFace {
            HorHintVC(sideCells: sides.t.0) { self.rotateCallback(.up) }
            HStack(spacing: Constants.cellSpacing) {
                VerHintVC(sideCells: sides.t.2) { self.rotateCallback(.left) }
                BoardVC(face: visible) { cell in
                    if self.gameStatus == .running {
                        self.selectedCell = cell
                        self.actionsEnabled = true
                    }
                }
                VerHintVC(sideCells: sides.t.3) { self.rotateCallback(.right) }
            }
            HorHintVC(sideCells: sides.t.1) { self.rotateCallback(.down) }
            Spacer()
            ActionsVC(enabled: self.actionsEnabled) { action in
                switch action {
                case .number:
                    print("Number image tapped")
                case .flag:
                    print("Flag button tapped")
                case .mine:
                    print("Mine button tapped")
                case .hint:
                    print("Hint button tapped")
                }
                
                if !self.selectedCell.isVoid {
                    self.updateCallback(self.selectedCell)
                    self.actionsEnabled = false
                }
            }
            Spacer()
        } else { Spacer() }
    }
}

struct GameVC_Previews: PreviewProvider {
    static var previews: some View {
        GameVC(
            sideFaces: BoardT_4([], [], [], []),
            visibleFace: Face(
                number: 4,
                references: References(4, top: 5, bottom: 2, left: 1, right: 6)
            ),
            gameStatus: .running,
            rotateCallback: { _ in },
            updateCallback: { _ in }
        )
    }
}
