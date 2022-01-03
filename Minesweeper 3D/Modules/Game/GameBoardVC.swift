//
//  GameBoardVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardVC: View {
    
    @ObservedObject var viewModel: GameBoardVM
    @State private var menuShown: Bool = false
    @State private var dismissAlertShown: Bool = false
    @State private var gameLost: Bool = false
    
    var closeCallback: (() -> Void)?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(self.viewModel.gameStatus.text.uppercased())
                .bold()
                .foregroundColor(Color.blue)
                .padding()
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
            if self.viewModel.gameStatus != .generating {
                GameVC(
                    sideFaces: self.viewModel.sideFaces,
                    visibleFace: self.viewModel.visibleFace,
                    gameStatus: self.viewModel.gameStatus,
                    rotateCallback: { self.viewModel.rotate($0) },
                    updateCallback: { self.viewModel.update(cell: $0, with: $1) { self.gameLost = true } }
                )
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
                    action: {
                        if self.viewModel.gameStatus == .lost { self.closeCallback?() }
                        else { self.dismissAlertShown.toggle() }
                    },
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
                            self.viewModel.saveGame { success in
                                if success { self.closeCallback?() }
                                else {
                                    // TODO: Create alert with error message
                                }
                            }
                        }
                    ),
                    secondaryButton: .default(
                        Text(Texts.no.localized),
                        action: { self.closeCallback?() }
                    )
                )
            }
        )
        .alert(
            isPresented: self.$gameLost,
            content: {
                Alert(
                    title: Text(Texts.info.localized),
                    message: Text(Texts.gameLost.localized),
                    primaryButton: .default(Text(Texts.options.localized), action: { self.menuShown = true }),
                    secondaryButton: .cancel(Text(Texts.close.localized), action: { self.closeCallback?() })
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
        GameBoardVC(viewModel: GameBoardVM(calculate: true), closeCallback: { })
    }
}
