//
//  GameBoardCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardCell: View {
    
    var faceNumber: Int
    
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 5,
            content: {
                ForEach((1...6), id: \.self) { _ in
                    VStack(
                        alignment: .center,
                        spacing: 5,
                        content: {
                            ForEach((1...6), id: \.self) { _ in
                                Text("\(self.faceNumber)")
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
        GameBoardCell(faceNumber: 4)
    }
}
