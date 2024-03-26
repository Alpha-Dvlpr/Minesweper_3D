//
//  MSImages.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI

enum MSImages {
    
    case numbers(Int)
    case symbols(MSSymbol)
    case system(MSSysImg)
    
    var image: Image {
        switch self {
        case .numbers(let number): return Image(systemName: "\(number).circle")
        case .symbols(let symbol):
            switch symbol {
            case .flag: return Image(systemName: "flag.circle")
            case .hint: return Image(systemName: "magnifyingglass.circle")
            case .mine: return Image(systemName: "ant.circle")
            case .unselected: return Image(systemName: "circle")
            case .void: return Image(systemName: "largecircle.fill.circle")
            }
        case .system(let sys):
            switch sys {
            case .cart: return Image(systemName: "cart")
            case .cellArrow: return Image(systemName: "chevron.right")
            case .clock: return Image(systemName: "clock")
            case .close: return Image(systemName: "xmark")
            case .closeKeyboard: return Image(systemName: "keyboard.chevron.compact.down")
            case .menu: return Image(systemName: "text.justify")
            case .pause: return Image(systemName: "pause")
            case .play: return Image(systemName: "play")
            case .rank: return Image(systemName: "list.star")
            case .restart: return Image(systemName: "repeat")
            case .settings: return Image(systemName: "gear")
            case .share: return Image(systemName: "arrowshape.turn.up.right")
            case .timer: return Image(systemName: "timer")
            case .trash: return Image(systemName: "trash")
            }
        }
    }
}
