//
//  CoreDataKeys.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

enum CoreDataKey: String {
    case settings
    case ranks
    
    var key: String {
        switch self {
        case .settings: return "com_alpha_dvlpr_settings"
        case .ranks: return "com_alpha_dvlpr_ranks"
        }
    }
}
