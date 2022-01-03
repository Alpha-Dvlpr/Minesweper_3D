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
    var updateCallback: ((Cell, Action) -> Void)
    
    var body: some View {
        if let sides = self.sideFaces, let visible = self.visibleFace {
            VStack(spacing: Constants.cellSpacing * 2) {
                HorHintVC(sideCells: sides.t.0) { self.rotateCallback(.up) }
                BoardDividerVC(horizontal: true)
                HStack(spacing: Constants.cellSpacing * 2) {
                    VerHintVC(sideCells: sides.t.2) { self.rotateCallback(.left) }
                    BoardDividerVC(horizontal: false)
                    BoardVC(face: visible) { cell in
                        if self.gameStatus == .running {
                            self.selectedCell = cell
                            self.actionsEnabled = true
                        }
                    }
                    BoardDividerVC(horizontal: false)
                    VerHintVC(sideCells: sides.t.3) { self.rotateCallback(.right) }
                }
                BoardDividerVC(horizontal: true)
                HorHintVC(sideCells: sides.t.1) { self.rotateCallback(.down) }
            }
            Spacer()
            ActionsVC(enabled: self.actionsEnabled) {
                if !self.selectedCell.isVoid {
                    self.updateCallback(self.selectedCell, $0)
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
            updateCallback: { (_, _) in }
        )
    }
}
