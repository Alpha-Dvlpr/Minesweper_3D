//
//  CoreDataKeys.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

enum CoreDataKey {
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
    case ranks
    case settings
    case status
    case time
    case username
    case visibleFace
    case maxNumberOfRanks
    
    var key: String {
        switch self {
        case .appLanguage: return "com_alpha_dvlpr_app_language"
        case .autoSaveRanks: return "com_alpha_dvlpr_auto_save_ranks"
        case .cellCanBeEdited: return "com_alpha_dvlpr_cell_can_be_edited"
        case .cellFace: return "com_alpha_dvlpr_cell_face"
        case .cellFlagged: return "com_alpha_dvlpr_cell_flagged"
        case .cellMined: return "com_alpha_dvlpr_cell_mined"
        case .cellOriginalContent: return "com_alpha_dvlpr_cell_original_content"
        case .cellShown: return "com_alpha_dvlpr_cell_shown"
        case .cellTappable: return "com_alpha_dvlpr_cell_tappable"
        case .cellXCor: return "com_alpha_dvlpr_cell_x_cor"
        case .cellYCor: return "com_alpha_dvlpr_cell_y_cor"
        case .faces: return "com_alpha_dvlpr_faces"
        case .faceCells: return "com_alpha_dvlpr_face_cells"
        case .faceGenerated: return "com_alpha_dvlpr_face_generated"
        case .faceNumber: return "com_alpha_dvlpr_face_number"
        case .faceReferencesBottom: return "com_alpha_dvlpr_face_references_bottom"
        case .faceReferencesBottomLast: return "com_alpha_dvlpr_face_references_bottom_last"
        case .faceReferencesLeft: return "com_alpha_dvlpr_face_references_left"
        case .faceReferencesLeftLast: return "com_alpha_dvlpr_face_references_left_last"
        case .faceReferencesRight: return "com_alpha_dvlpr_face_references_right"
        case .faceReferencesRightLast: return "com_alpha_dvlpr_face_references_right_last"
        case .faceReferencesSelf: return "com_alpha_dvlpr_face_references_self"
        case .faceReferencesSelfLast: return "com_alpha_dvlpr_face_references_self_last"
        case .faceReferencesTop: return "com_alpha_dvlpr_face_references_top"
        case .faceReferencesTopLast: return "com_alpha_dvlpr_face_references_top_last"
        case .game: return "com_alpha_dvlpr_game"
        case .ranks: return "com_alpha_dvlpr_ranks"
        case .settings: return "com_alpha_dvlpr_settings"
        case .status: return "com_alpha_dvlpr_status"
        case .time: return "com_alpha_dvlpr_time"
        case .username: return "com_alpha_dvlpr_username"
        case .visibleFace: return "com_alpha_dvlpr_visibleFace"
        case .maxNumberOfRanks: return "com_alpha_dvlpr_max_number_of_ranks"
        }
    }
}
