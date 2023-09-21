//
//  MSImages.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

enum MSSysImg {
    case cart
    case cellArrow
    case clock
    case close
    case closeKeyboard
    case menu
    case pause
    case play
    case rank
    case restart
    case settings
    case share
    case timer
    case trash
}

enum MSSymbol {
    case flag
    case hint
    case mine
    case unselected
    case void
}

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

struct MSSettingsImage: View {
    
    var number: Int = 0
    
    var body: some View {
        if number == 0 {
            MSImages.system(.settings).image
        } else {
            MSImages.system(.settings).image
                .overlay(
                    MSImages.numbers(number).image
                        .resizable()
                        .background(Color.white)
                        .clipShape(Circle())
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color.red),
                    alignment: .topTrailing
                )
        }
    }
}
