//
//  GameBoardVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardVC: View {
    
    @State var gameTime: Int = 0
    @ObservedObject private var viewModel = GameBoardVM()
    
    var items: [Int] = [0, 1, 2, 3, 4, 5]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            HorizontalHintCell(sideScreen: self.viewModel.visibleFace.topReference)
                .onTapGesture { self.viewModel.rotate(.up) }
            HStack(spacing: 5) {
                VerticalHintCell(sideScreen: self.viewModel.visibleFace.leftReference)
                    .onTapGesture { self.viewModel.rotate(.left) }
                GameBoardCell(faceNumber: self.viewModel.visibleFace.number)
                VerticalHintCell(sideScreen: self.viewModel.visibleFace.rightReference)
                    .onTapGesture { self.viewModel.rotate(.right) }
            }
            .padding()
            HorizontalHintCell(sideScreen: self.viewModel.visibleFace.bottomReference)
                .onTapGesture { self.viewModel.rotate(.down) }
            Spacer()
        }
        .onReceive(self.timer) { _ in self.gameTime += 1 }
        .navigationBarTitle(
            Utils.getStringTime(seconds: self.gameTime),
            displayMode: .inline
        )
        .navigationBarItems(
            trailing:
                Images.menu.system
                .onTapGesture { }
        )
    }
}

struct GameBoardVC_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardVC()
    }
}
