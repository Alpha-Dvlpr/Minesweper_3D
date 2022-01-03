//
//  BoardDividerVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 03/01/2022.
//

import SwiftUI

struct BoardDividerVC: View {
    
    var horizontal: Bool
    var width: CGFloat {
        return self.horizontal
            ? Constants.cellSide * 10
            : Constants.cellSpacing * 6
    }
    var height: CGFloat {
        return self.horizontal
            ? Constants.cellSpacing * 6
            : Constants.cellSide * 10
    }
    
    var body: some View {
        Spacer()
            .frame(width: self.width, height: self.height)
            .background(Color.gray)
            .cornerRadius(16)
    }
}

struct BoardDividerVC_Previews: PreviewProvider {
    static var previews: some View {
        BoardDividerVC(horizontal: false)
    }
}
