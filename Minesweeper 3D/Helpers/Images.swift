//
//  Images.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

enum ImageNumber: Int {
    case flag = 15
    case mine = 20
    case void = -1
    case unselected = -2
}

enum Images {
    enum SysImg {
        case settings
        case play
        case pause
        case restart
        case rank
        case cellArrow
        case menu
        case close
        case closeKeyboard
    }
    
    case system(SysImg)
    case custom
    case numbers(Int)
    
    var image: Image {
        switch self {
        case .system(let sys):
            switch sys {
            case .settings: return Image(systemName: "gear")
            case .play: return Image(systemName: "play")
            case .pause: return Image(systemName: "pause")
            case .restart: return Image(systemName: "repeat")
            case .rank: return Image(systemName: "list.star")
            case .cellArrow: return Image(systemName: "chevron.right")
            case .menu: return Image(systemName: "text.justify")
            case .close: return Image(systemName: "xmark")
            case .closeKeyboard: return Image(systemName: "keyboard.chevron.compact.down")
            }
        case .custom:
            return Image(systemName: "xmark.circle")
        case .numbers(let number):
            switch number {
            case 1, 2, 3, 4, 5, 6, 7, 8, 9: return Image(systemName: "\(number).circle")
            case ImageNumber.flag.rawValue: return Image(systemName: "flag.circle")
            case ImageNumber.mine.rawValue: return Image(systemName: "ant.circle")
            case ImageNumber.void.rawValue: return Image(systemName: "largecircle.fill.circle")
            case ImageNumber.unselected.rawValue: return Image(systemName: "circle")
            default: return Image(systemName: "circle")
            }
        }
    }
}
