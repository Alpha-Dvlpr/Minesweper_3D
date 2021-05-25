//
//  GameBoardVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardVC: View {
    
    @ObservedObject private var viewModel = GameBoardVM()
    @State private var menuShown: Bool = false
    
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
                    GameBoardCell(
                        face: self.viewModel.visibleFace,
                        boardCallback: { self.viewModel.rotateFace(degrees: .negativeQuart) }
                    )
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
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Images.system(.close).image.onTapGesture { self.viewModel.closeButtonTapped() }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                self.viewModel.actionBarButton.onTapGesture { self.viewModel.pauseResumeButtonTapped() }
                Images.system(.menu).image.onTapGesture { self.menuShown.toggle() }
            }
        }
        .actionSheet(
            isPresented: self.$menuShown,
            content: {
                ActionSheet(
                    title: Text(""),
                    buttons: [
                        .default(Text(Texts.restartGame.localized), action: { self.viewModel.restartGame() }),
                        .default(Text(Texts.newGame.localized), action: { self.viewModel.newGame() }),
                        .cancel(Text(Texts.cancel.localized))
                    ]
                )
            }
        )
    }
}

struct GameBoardVC_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardVC()
    }
}
