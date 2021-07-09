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
    @State private var dismissAlertShown: Bool = false
    var closeCallback: (() -> Void)?
    
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
                HorizontalHintCell(sideScreen: self.viewModel.visibleFace.references.top)
                    .onTapGesture { self.viewModel.rotate(.up) }
                HStack(spacing: Constants.boardSpacing) {
                    VerticalHintCell(sideScreen: self.viewModel.visibleFace.references.left)
                        .onTapGesture { self.viewModel.rotate(.left) }
                    GameBoardCell(
                        face: self.viewModel.visibleFace,
                        boardCallback: { self.viewModel.updateCellVisibility(x: $0, y: $1) }
                    )
                    VerticalHintCell(sideScreen: self.viewModel.visibleFace.references.right)
                        .onTapGesture { self.viewModel.rotate(.right) }
                }
                HorizontalHintCell(sideScreen: self.viewModel.visibleFace.references.bottom)
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
                Button(
                    action: { self.dismissAlertShown.toggle() },
                    label: { Images.system(.close).image }
                )
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(
                    action: { self.viewModel.pauseResumeButtonTapped() },
                    label: { self.viewModel.actionBarButton }
                )
                Button(
                    action: { self.menuShown.toggle() },
                    label: { Images.system(.menu).image }
                )
            }
        }
        .alert(
            isPresented: self.$dismissAlertShown,
            content: {
                Alert(
                    title: Text(Texts.finishGame.localized),
                    message: Text(Texts.finishGameDisclaimer.localized),
                    primaryButton: .default(
                        Text(Texts.yes.localized),
                        action: {
                            // TODO: Call viewmodel to save current game stuff then dismiss
                            self.closeCallback?()
                        }
                    ),
                    secondaryButton: .default(
                        Text(Texts.no.localized),
                        action: { self.closeCallback?() }
                    )
                )
            }
        )
        .actionSheet(
            isPresented: self.$menuShown,
            content: {
                ActionSheet(
                    title: Text(Texts.menu.localized.uppercased()),
                    buttons: [
                        .default(
                            Text(Texts.restartGame.localized),
                            action: { self.viewModel.restartGame() }
                        ),
                        .default(
                            Text(Texts.newGame.localized),
                            action: { self.viewModel.newGame() }
                        ),
                        .cancel(Text(Texts.cancel.localized))
                    ]
                )
            }
        )
    }
}

struct GameBoardVC_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardVC(closeCallback: { })
    }
}
