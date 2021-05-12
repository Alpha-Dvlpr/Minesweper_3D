//
//  Images.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

enum Images {
    case settings
    case play
    case pause
    case restart
    case rank
    case cellArrow
    case trash
    case menu
    case close
    
    var system: Image {
        switch self {
        case .settings: return Image(systemName: "gear")
        case .play: return Image(systemName: "play")
        case .pause: return Image(systemName: "pause")
        case .restart: return Image(systemName: "repeat")
        case .rank: return Image(systemName: "list.star")
        case .cellArrow: return Image(systemName: "chevron.right")
        case .trash: return Image(systemName: "trash")
        case .menu: return Image(systemName: "text.justify")
        case .close: return Image(systemName: "xmark")
        }
    }
}
