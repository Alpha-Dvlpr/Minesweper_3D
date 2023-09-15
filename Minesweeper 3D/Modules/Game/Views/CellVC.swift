//
//  CellVC.swift
//  Minesweeper 3D
//
//  Created by Aaron on 14/7/21.
//

import SwiftUI

//struct CellVC: View {
//    
//    var cell: Cell
//    var cellCallback: ((Cell) -> Void)
//    private var image: Image {
//        return self.cell.shown
//            ? self.cell.content.display
//            : self.cell.content.display(
//                flagged: self.cell.flagged,
//                mined: self.cell.mined
//            )
//    }
//    
//    var body: some View {
//        self.image
//            .resizable()
//            .frame(width: Constants.cellSide, height: Constants.cellSide)
//            .foregroundColor(self.cell.shown ? self.cell.content.color : nil)
//            .onTapGesture { self.cellCallback(self.cell) }
//    }
//}

//struct CellVC_Previews: PreviewProvider {
//    static var previews: some View {
//        CellVC(cell: Cell(face: 4, xCor: 4, yCor: 5, content: .mine), cellCallback: { _ in })
//    }
//}
