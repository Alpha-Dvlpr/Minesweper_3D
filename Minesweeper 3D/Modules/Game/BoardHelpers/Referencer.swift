//
//  Referencer.swift
//  Minesweeper 3D
//
//  Created by Aaron on 13/7/21.
//

import Foundation

class Referencer {
    
    private let firstIndex = 1
    private let lastIndex = Constants.numberOfItems - 2
    
    /// Faces -> (Top, Bottom)
    func getHorizontalFaces(for face: Int, on faces: FaceT_6) -> BoardT_2? {
        switch face {
        case 1:
            let topLast = faces.t.4.cells.b.horizontal(at: self.lastIndex) ?? []
            let bottomFirst = faces.t.1.cells.b.horizontal(at: self.firstIndex) ?? []
            
            return BoardT_2(topLast, bottomFirst).ok
        case 2:
            let topLast = faces.t.0.cells.b.horizontal(at: self.lastIndex) ?? []
            let bottomFirst = faces.t.5.cells.b.horizontal(at: self.firstIndex) ?? []
            
            return BoardT_2(topLast, bottomFirst).ok
        case 3:
            let topLast = faces.t.4.cells.b.vertical(at: self.firstIndex) ?? []
            let bottomFirst = faces.t.1.cells.b.vertical(at: self.firstIndex, reversed: true) ?? []
            
            return BoardT_2(topLast, bottomFirst).ok
        case 4:
            let topLast = faces.t.4.cells.b.vertical(at: self.lastIndex, reversed: true) ?? []
            let bottomFirst = faces.t.1.cells.b.vertical(at: self.lastIndex) ?? []
            
            return BoardT_2(topLast, bottomFirst).ok
        case 5:
            let topLast = faces.t.5.cells.b.horizontal(at: self.lastIndex) ?? []
            let bottomFirst = faces.t.0.cells.b.horizontal(at: self.firstIndex) ?? []
            
            return BoardT_2(topLast, bottomFirst).ok
        case 6:
            let topLast = faces.t.1.cells.b.horizontal(at: self.lastIndex) ?? []
            let bottomFirst = faces.t.4.cells.b.horizontal(at: self.firstIndex) ?? []
            
            return BoardT_2(topLast, bottomFirst).ok
        default: return nil
        }
    }
    
    /// Faces -> (Left, Right)
    func getVerticalFaces(for face: Int, on faces: FaceT_6) -> BoardT_2? {
        switch face {
        case 1:
            let leftLast = faces.t.2.cells.b.vertical(at: self.lastIndex) ?? []
            let rightFirst = faces.t.3.cells.b.vertical(at: self.firstIndex) ?? []
            
            return BoardT_2(leftLast, rightFirst).ok
        case 2:
            let leftLast = faces.t.2.cells.b.horizontal(at: self.lastIndex, reversed: true) ?? []
            let rightFirst = faces.t.3.cells.b.horizontal(at: self.lastIndex) ?? []
            
            return BoardT_2(leftLast, rightFirst).ok
        case 3:
            let leftLast = faces.t.5.cells.b.vertical(at: self.firstIndex, reversed: true) ?? []
            let rightFirst = faces.t.0.cells.b.vertical(at: self.firstIndex) ?? []
            
            return BoardT_2(leftLast, rightFirst).ok
        case 4:
            let leftLast = faces.t.0.cells.b.vertical(at: self.lastIndex) ?? []
            let rightFirst = faces.t.5.cells.b.vertical(at: self.lastIndex, reversed: true) ?? []
            
            return BoardT_2(leftLast, rightFirst).ok
        case 5:
            let leftLast = faces.t.2.cells.b.horizontal(at: self.firstIndex) ?? []
            let rightFirst = faces.t.3.cells.b.horizontal(at: self.firstIndex, reversed: true) ?? []
            
            return BoardT_2(leftLast, rightFirst).ok
        case 6:
            let leftLast = faces.t.2.cells.b.vertical(at: self.firstIndex, reversed: true) ?? []
            let rightFirst = faces.t.3.cells.b.vertical(at: self.lastIndex, reversed: true) ?? []
            
            return BoardT_2(leftLast, rightFirst).ok
        default: return nil
        }
    }
    
    /// Faces -> (Top, Bottom, Left, Right)
    func getCornerReferences(for face: Int, on faces: FaceT_6) -> BoardT_4? {
        guard let horizontal = self.getHorizontalFaces(for: face, on: faces),
              let vertical = self.getVerticalFaces(for: face, on: faces)
        else { return nil }
        
        return BoardT_4(horizontal.t.0, horizontal.t.1, vertical.t.0, vertical.t.1).ok
    }
}
