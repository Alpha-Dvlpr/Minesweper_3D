//
//  GameBoardVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import SwiftUI

enum Direction {
    case up
    case down
    case left
    case right
}

class GameBoardVM: ObservableObject {
    
    @Published var visibleFace: Face!
    
    private var faces = [Face]()
    
    init() {
        self.generateFaceNumbers()
    }
    
    func rotate(_ direction: Direction) {
        if let linkedFace = self.faces.first(where: { $0.number == self.getReference(for: direction) }) {
            let aux = linkedFace
            
            switch direction {
            case .up:
                aux.topReference = (7 - self.visibleFace.number)
                aux.bottomReference = self.visibleFace.number
                aux.leftReference = self.visibleFace.leftReference
                aux.rightReference = self.visibleFace.rightReference
            case .down:
                aux.topReference = self.visibleFace.number
                aux.bottomReference = (7 - self.visibleFace.number)
                aux.leftReference = self.visibleFace.leftReference
                aux.rightReference = self.visibleFace.rightReference
            case .left:
                aux.topReference = self.visibleFace.topReference
                aux.bottomReference = self.visibleFace.bottomReference
                aux.leftReference = (7 - self.visibleFace.number)
                aux.rightReference = self.visibleFace.number
            case .right:
                aux.topReference = self.visibleFace.topReference
                aux.bottomReference = self.visibleFace.bottomReference
                aux.leftReference = self.visibleFace.number
                aux.rightReference = (7 - self.visibleFace.number)
            }
            
            self.visibleFace = aux
        }
    }
    
    func getReference(for direction: Direction) -> Int {
        switch direction {
        case .up: return self.visibleFace.topReference
        case .down: return self.visibleFace.bottomReference
        case .left: return self.visibleFace.leftReference
        case .right: return self.visibleFace.rightReference
        }
    }
    
    private func generateFaceNumbers() {
        let face1 = Face(number: 1)
        face1.topReference = 5
        face1.bottomReference = 2
        face1.leftReference = 3
        face1.rightReference = 4
        
        let face2 = Face(number: 2)
        let face3 = Face(number: 3)
        let face4 = Face(number: 4)
        let face5 = Face(number: 5)
        let face6 = Face(number: 6)
        
        self.faces = [face1, face2, face3, face4, face5, face6]
        
        self.visibleFace = face1
    }
}
