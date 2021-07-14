//
//  Referencer.swift
//  Minesweeper 3D
//
//  Created by Aaron on 13/7/21.
//

import Foundation

class Referencer {
    
    /// Faces -> (Top, Bottom)
    func getHorizontalFaces(for face: Int, on faces: FaceT_6) -> ([Cell]?, [Cell]?) {
        switch face {
        case 1:
            let topLast = faces.t.4.cells.b.last
            let bottomFirst = faces.t.1.cells.b.first
            
            return (topLast, bottomFirst)
        case 2:
            let topLast = faces.t.0.cells.b.last
            let bottomFirst = faces.t.5.cells.b.first

            return (topLast, bottomFirst)
        case 3:
            let topLast = faces.t.4.cells.getFirstVertical()
            let bottomFirst = faces.t.1.cells.getFirstVertical(reversed: true)
            
            return (topLast, bottomFirst)
        case 4:
            let topLast = faces.t.4.cells.getLastVertical(reversed: true)
            let bottomFirst = faces.t.1.cells.getLastVertical()
            
            return (topLast, bottomFirst)
        case 5:
            let topLast = faces.t.5.cells.b.last
            let bottomFirst = faces.t.0.cells.b.first
            
            return (topLast, bottomFirst)
        case 6:
            let topLast = faces.t.1.cells.b.last
            let bottomFirst = faces.t.4.cells.b.first
            
            return (topLast, bottomFirst)
        default: return (nil, nil)
        }
    }
    
    /// Faces -> (Left, Right)
    func getVerticalFaces(for face: Int, on faces: FaceT_6) -> ([Cell]?, [Cell]?) {
        switch face {
        case 1:
            let leftLast = faces.t.2.cells.getLastVertical()
            let rightFirst = faces.t.3.cells.getFirstVertical()
            
            return (leftLast, rightFirst)
        case 2:
            let leftLast = faces.t.2.cells.b.last
            let rightFirst = faces.t.3.cells.b.last
            
            return (leftLast?.reversed(), rightFirst)
        case 3:
            let leftLast = faces.t.5.cells.getFirstVertical(reversed: true)
            let rightFirst = faces.t.0.cells.getFirstVertical()
            
            return (leftLast, rightFirst)
        case 4:
            let leftLast = faces.t.0.cells.getFirstVertical()
            let rightFirst = faces.t.5.cells.getLastVertical(reversed: true)
            
            return (leftLast, rightFirst)
        case 5:
            let leftLast = faces.t.2.cells.b.first
            let rightFirst = faces.t.3.cells.b.first
            
            return (leftLast, rightFirst?.reversed())
        case 6:
            let leftLast = faces.t.2.cells.getFirstVertical(reversed: true)
            let rightFirst = faces.t.3.cells.getLastVertical(reversed: true)
            
            return (leftLast, rightFirst)
        default: return (nil, nil)
        }
    }
    
    /// Faces -> (Top, Bottom, Left, Right)
    func getCornerReferences(for face: Int, on faces: FaceT_6) -> ([Cell]?, [Cell]?, [Cell]?, [Cell]?) {
        let horizontal = self.getHorizontalFaces(for: face, on: faces)
        let vertical = self.getVerticalFaces(for: face, on: faces)
        
        return (horizontal.0, horizontal.1, vertical.0, vertical.1)
    }
}
