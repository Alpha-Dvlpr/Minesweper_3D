//
//  FaceCD.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 05/01/2022.
//

import Foundation

//class FaceCD: NSObject, NSCoding {
//    
//    var number: Int
//    var references: References
//    var cells: [[CellCD]]
//    var generated: Bool
//    var lastReferences: References
// 
//    init(number: Int, references: References, cells: Board, generated: Bool, lastReferences: References) {
//        self.number = number
//        self.references = references
//        self.cells = cells.b.map { return $0.map { return $0.getCellCD() } }
//        self.generated = generated
//        self.lastReferences = lastReferences
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        let _self = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesSelf.key)
//        let top = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesTop.key)
//        let bottom = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesBottom.key)
//        let left = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesLeft.key)
//        let right = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesRight.key)
//        let _selfLast = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesSelfLast.key)
//        let topLast = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesTopLast.key)
//        let bottomLast = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesBottomLast.key)
//        let leftLast = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesLeftLast.key)
//        let rightLast = aDecoder.decodeInteger(forKey: CoreDataKey.faceReferencesRightLast.key)
//        
//        self.number = aDecoder.decodeInteger(forKey: CoreDataKey.faceNumber.key)
//        self.references = References(_self, top: top, bottom: bottom, left: left, right: right)
//        self.cells = aDecoder.decodeObject(forKey: CoreDataKey.faceCells.key) as? [[CellCD]] ?? []
//        self.generated = aDecoder.decodeBool(forKey: CoreDataKey.faceGenerated.key)
//        self.lastReferences = References(_selfLast, top: topLast, bottom: bottomLast, left: leftLast, right: rightLast)
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.number, forKey: CoreDataKey.faceNumber.key)
//        aCoder.encode(self.references._self, forKey: CoreDataKey.faceReferencesSelf.key)
//        aCoder.encode(self.references.top, forKey: CoreDataKey.faceReferencesTop.key)
//        aCoder.encode(self.references.bottom, forKey: CoreDataKey.faceReferencesBottom.key)
//        aCoder.encode(self.references.left, forKey: CoreDataKey.faceReferencesLeft.key)
//        aCoder.encode(self.references.right, forKey: CoreDataKey.faceReferencesRight.key)
//        aCoder.encode(self.cells, forKey: CoreDataKey.faceCells.key)
//        aCoder.encode(self.generated, forKey: CoreDataKey.faceGenerated.key)
//        aCoder.encode(self.lastReferences._self, forKey: CoreDataKey.faceReferencesSelfLast.key)
//        aCoder.encode(self.lastReferences.top, forKey: CoreDataKey.faceReferencesTopLast.key)
//        aCoder.encode(self.lastReferences.bottom, forKey: CoreDataKey.faceReferencesBottomLast.key)
//        aCoder.encode(self.lastReferences.left, forKey: CoreDataKey.faceReferencesLeftLast.key)
//        aCoder.encode(self.lastReferences.right, forKey: CoreDataKey.faceReferencesRightLast.key)
//    }
//}
