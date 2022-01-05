//
//  CellCD.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 05/01/2022.
//

import Foundation

class CellCD: NSObject, NSCoding {
    
    var xCor: Int
    var yCor: Int
    var shown: Bool
    var tappable: Bool
    var flagged: Bool
    var mined: Bool
    var canBeEdited: Bool
    var face: Int
    var originalContent: CellContent
    
    init(
        xCor: Int,
        yCor: Int,
        shown: Bool,
        tappable: Bool,
        flagged: Bool,
        mined: Bool,
        canBeEdited: Bool,
        face: Int,
        originalContent: CellContent
    ) {
        self.xCor = xCor
        self.yCor = yCor
        self.shown = shown
        self.tappable = tappable
        self.flagged = flagged
        self.mined = mined
        self.canBeEdited = canBeEdited
        self.face = face
        self.originalContent = originalContent
    }
    
    required init(coder aDecoder: NSCoder) {
        let contentKey = aDecoder.decodeObject(forKey: CoreDataKey.cellOriginalContent.key) as? String ?? ""
        
        self.xCor = aDecoder.decodeInteger(forKey: CoreDataKey.cellXCor.key)
        self.yCor = aDecoder.decodeInteger(forKey: CoreDataKey.cellYCor.key)
        self.shown = aDecoder.decodeBool(forKey: CoreDataKey.cellShown.key)
        self.tappable = aDecoder.decodeBool(forKey: CoreDataKey.cellTappable.key)
        self.flagged = aDecoder.decodeBool(forKey: CoreDataKey.cellFlagged.key)
        self.mined = aDecoder.decodeBool(forKey: CoreDataKey.cellMined.key)
        self.canBeEdited = aDecoder.decodeBool(forKey: CoreDataKey.cellCanBeEdited.key)
        self.face = aDecoder.decodeInteger(forKey: CoreDataKey.cellFace.key)
        self.originalContent = CellContent(from: contentKey)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.xCor, forKey: CoreDataKey.cellXCor.key)
        aCoder.encode(self.yCor, forKey: CoreDataKey.cellYCor.key)
        aCoder.encode(self.shown, forKey: CoreDataKey.cellShown.key)
        aCoder.encode(self.tappable, forKey: CoreDataKey.cellTappable.key)
        aCoder.encode(self.flagged, forKey: CoreDataKey.cellFlagged.key)
        aCoder.encode(self.mined, forKey: CoreDataKey.cellMined.key)
        aCoder.encode(self.canBeEdited, forKey: CoreDataKey.cellCanBeEdited.key)
        aCoder.encode(self.face, forKey: CoreDataKey.cellFace.key)
        aCoder.encode(self.originalContent.settingKey, forKey: CoreDataKey.cellOriginalContent.key)
    }
}
