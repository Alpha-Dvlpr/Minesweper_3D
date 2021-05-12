//
//  GameBoardCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardCell: View {
    
    var rows: [Int] = [0, 1, 2, 3, 4, 5]
    var columns: [String] = ["A", "B", "C", "D", "E", "F"]
    
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 5,
            content: {
                ForEach(self.columns, id: \.self) { column in
                    VStack(
                        alignment: .center,
                        spacing: 5,
                        content: {
                            ForEach(self.rows, id: \.self) { row in
                                Text("[\(column),\(row)]")
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .frame(width: 40, height: 40)
                                    .background(Color.green)
                                    .border(Color.gray, width: 1)
                                    .font(.caption)
                            }
                        }
                    )
                }
            }
        )
    }
}

struct GameBoardCell_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardCell()
    }
}
