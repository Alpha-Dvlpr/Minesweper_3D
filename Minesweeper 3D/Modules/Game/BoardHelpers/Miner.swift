//
//  Miner.swift
//  Minesweeper 3D
//
//  Created by Aaron on 13/7/21.
//

import Foundation

//class Miner {
//    
//    func placeMines(on board: Board, completion: @escaping ((Board) -> Void)) {
//        var generatedMines = board.b.map { $0.filter { $0.content == .mine }.count }.reduce(0, +)
//        
//        while generatedMines < Constants.numberOfMinesPerFace {
//            let coords = self.generateRandomCoords()
//            let cell = board.b[coords.0][coords.1]
//
//            if cell.content == .mine || !cell.canBeEdited { continue }
//            else {
//                board.b[coords.0][coords.1].updateContent(to: .mine)
//                generatedMines += 1
//            }
//            
//            cell.canBeEdited = false
//        }
//
//        completion(board)
//    }
//
//    private func generateRandomCoords() -> (Int, Int) {
//        let number1 = Int.random(max: Constants.numberOfItems)
//        let number2 = Int.random(max: Constants.numberOfItems)
//        
//        return (number1, number2)
//    }
//}
