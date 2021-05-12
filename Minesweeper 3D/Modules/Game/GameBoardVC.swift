//
//  GameBoardVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardVC: View {
    
    @ObservedObject private var viewModel = GameBoardVM()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(self.viewModel.gameStatus.text.uppercased())
                .bold()
                .foregroundColor(Color.blue)
                .padding()
                .font(.title)
            Spacer()
            VStack(spacing: Constants.boardSpacing) {
                HorizontalHintCell(sideScreen: self.viewModel.visibleFace.topReference)
                    .onTapGesture { self.viewModel.rotate(.up) }
                HStack(spacing: Constants.boardSpacing) {
                    VerticalHintCell(sideScreen: self.viewModel.visibleFace.leftReference)
                        .onTapGesture { self.viewModel.rotate(.left) }
                    GameBoardCell(faceNumber: self.viewModel.visibleFace.number)
                    VerticalHintCell(sideScreen: self.viewModel.visibleFace.rightReference)
                        .onTapGesture { self.viewModel.rotate(.right) }
                }
                HorizontalHintCell(sideScreen: self.viewModel.visibleFace.bottomReference)
                    .onTapGesture { self.viewModel.rotate(.down) }
            }
            Spacer()
        }
        .onReceive(self.timer) { _ in self.viewModel.updateTime() }
        .navigationBarTitle(
            self.viewModel.stringTime,
            displayMode: .inline
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Images.close.system.onTapGesture { self.viewModel.closeButtonTapped() },
            trailing:
                HStack(spacing: 15) {
                    self.viewModel.actionBarButton.onTapGesture { self.viewModel.pauseResumeGame() }
                    Images.menu.system.onTapGesture { }
                }
        )
    }
}

struct GameBoardVC_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardVC()
    }
}
