//
//  MSBoardDivider.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 29/3/24.
//

import SwiftUI

struct MSBoardDivider: View {

    enum MSBoarDividerOrientation {
        case horizontal
        case vertical
    }
    
    var orientation: MSBoarDividerOrientation
    
    var width: CGFloat {
        switch orientation {
        case .horizontal: return MSConstants.cellSide * CGFloat(MSConstants.numberOfItems)
        case .vertical: return MSConstants.cellSpacing * 6
        }
    }
    var height: CGFloat {
        switch orientation {
        case .horizontal: return MSConstants.cellSpacing * 6
        case .vertical: return MSConstants.cellSide * CGFloat(MSConstants.numberOfItems)
        }
    }
    
    var body: some View {
        Capsule(style: .circular)
            .frame(width: width, height: height)
            .foregroundStyle(.gray)
    }
}
