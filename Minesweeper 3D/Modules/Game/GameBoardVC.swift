//
//  GameBoardVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardVC: View {
    
    var items: [Int] = [0, 1, 2, 3, 4, 5]
    @State var gameTime: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            HorizontalHintCell(items: self.items, sideScreen: 3)
            HStack(spacing: 5) {
                VerticalHintCell(items: self.items, sideScreen: 4)
                GameBoardCell()
                VerticalHintCell(items: self.items, sideScreen: 5)
            }
            .padding()
            HorizontalHintCell(items: self.items, sideScreen: 2)
            Spacer()
        }
        .onReceive(self.timer) { _ in self.gameTime += 1 }
        .navigationBarTitle(
            Utils.getStringTime(seconds: self.gameTime),
            displayMode: .inline
        )
    }
}

struct GameBoardVC_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardVC()
    }
}
