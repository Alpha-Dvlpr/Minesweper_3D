//
//  CoreDataKeys.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

enum CoreDataKey {
    case settings
    case ranks
    case username
    case appLanguage
    case autoSaveRanks
    case maxNumberOfRanks
    
    var key: String {
        switch self {
        case .settings: return "com_alpha_dvlpr_settings"
        case .ranks: return "com_alpha_dvlpr_ranks"
        case .username: return "com_alpha_dvlpr_username"
        case .appLanguage: return "com_alpha_dvlpr_app_language"
        case .autoSaveRanks: return "com_alpha_dvlpr_auto_save_ranks"
        case .maxNumberOfRanks: return "com_alpha_dvlpr_max_number_of_ranks"
        }
    }
}
