//
//  Referencer.swift
//  Minesweeper 3D
//
//  Created by Aaron on 13/7/21.
//

import Foundation

class Referencer {
    
    /// Faces -> (Top, Bottom)
    func getHorizontalFaces(for face: Int, on faces: FaceT_6) -> FaceT_2? {
        switch face {
        case 1: return FaceT_2(faces.t.4, faces.t.1)
        case 2: return FaceT_2(faces.t.0, faces.t.5)
        case 3: return FaceT_2(faces.t.4, faces.t.1)
        case 4: return FaceT_2(faces.t.4, faces.t.1)
        case 5: return FaceT_2(faces.t.5, faces.t.0)
        case 6: return FaceT_2(faces.t.1, faces.t.4)
        default: return nil
        }
    }
    
    /// Faces -> (Left, Right)
    func getVerticalFaces(for face: Int, on faces: FaceT_6) -> FaceT_2? {
        switch face {
        case 1: return FaceT_2(faces.t.2, faces.t.3)
        case 2: return FaceT_2(faces.t.2, faces.t.3)
        case 3: return FaceT_2(faces.t.5, faces.t.0)
        case 4: return FaceT_2(faces.t.0, faces.t.5)
        case 5: return FaceT_2(faces.t.2, faces.t.3)
        case 6: return FaceT_2(faces.t.2, faces.t.3)
        default: return nil
        }
    }
    
    /// Faces -> (Top, Bottom, Left, Right)
    func getCornerReferences(for face: Int, on faces: FaceT_6) -> FaceT_4? {
        guard let horizontal = self.getHorizontalFaces(for: face, on: faces),
              let vertical = self.getVerticalFaces(for: face, on: faces)
        else { return nil }
        
        return FaceT_4(horizontal.t.0, horizontal.t.1, vertical.t.0, vertical.t.1)
    }
}
