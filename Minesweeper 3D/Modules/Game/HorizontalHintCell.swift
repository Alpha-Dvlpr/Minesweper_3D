//
//  HorizontalHintCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct HorizontalHintCell: View {
    
    var items: [Int]
    var sideScreen: Int
    
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 5,
            content: {
                ForEach(self.items, id: \.self) { value in
                    Text("[\(self.sideScreen),\(value)]")
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(width: 40, height: 40, alignment: .center)
                        .background(Color.green)
                        .border(Color.gray, width: 1)
                }
            }
        )
    }
}

struct HorizontalHintCell_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalHintCell(items: [0, 1, 2, 3, 4, 5], sideScreen: 4)
    }
}
