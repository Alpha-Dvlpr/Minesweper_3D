//
//  MSCoreDataKeys.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

enum MSCoreDataKey: String {
    case appLanguage
    case autoSaveRanks
    case cellCanBeEdited
    case cellFace
    case cellFlagged
    case cellMined
    case cellOriginalContent
    case cellShown
    case cellTappable
    case cellXCor
    case cellYCor
    case faces
    case faceCells
    case faceGenerated
    case faceNumber
    case faceReferencesBottom
    case faceReferencesBottomLast
    case faceReferencesLeft
    case faceReferencesLeftLast
    case faceReferencesRight
    case faceReferencesRightLast
    case faceReferencesSelf
    case faceReferencesSelfLast
    case faceReferencesTop
    case faceReferencesTopLast
    case game
    case settings
    case status
    case time
    case username
    case visibleFace
    case maxNumberOfRanks
    
    var key: String {
        let const = "com_alpha_dvlpr_"
        return const.appending(self.rawValue)
    }
}
