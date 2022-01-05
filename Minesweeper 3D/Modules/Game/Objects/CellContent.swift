//
//  CellContent.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/5/21.
//

import SwiftUI

enum CellContent: Hashable {

    case mine
    case number(Int)
    case flagged
    case unselected
    case void
    
    init(from key: String) {
        switch key {
        case "*": self = .mine
        case "F": self = .flagged
        case "O": self = .unselected
        case " ": self = .void
        default: self = .number(Int(key)!)
        }
    }
    
    func display(flagged: Bool, mined: Bool) -> Image {
        return flagged
            ? Images.symbols(.flag).image
            : Images.symbols(mined ? .mine : .unselected).image
    }
    
    var settingKey: String {
        switch self {
        case .mine: return "*"
        case .number(let number): return "\(number)"
        case .flagged: return "F"
        case .unselected: return "O"
        case .void: return " "
        }
    }
    
    var display: Image {
        switch self {
        case .mine: return Images.symbols(.mine).image
        case .number(let number): return Images.numbers(number).image
        case .flagged: return Images.symbols(.flag).image
        case .unselected: return Images.symbols(.unselected).image
        case .void: return Images.symbols(.void).image
        }
    }
    
    var color: Color? {
        switch self {
        case .number(let number):
            switch number {
            case 1: return Color.init(UIColor.systemBlue)
            case 2: return Color.init(UIColor.systemGreen)
            case 3: return Color.init(UIColor.systemRed)
            case 4: return Color.init(UIColor.magenta)
            case 5: return Color.init(UIColor.brown)
            case 6: return Color.init(UIColor.cyan)
            case 7: return Color.init(UIColor.orange)
            case 8: return Color.init(UIColor.systemGray)
            case 9: return Color.init(UIColor.purple)
            default: return nil
            }
        default: return nil
        }
    }
}
