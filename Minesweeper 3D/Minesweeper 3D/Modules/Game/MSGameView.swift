//
//  MSGameView.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 27/3/24.
//

import SwiftUI

struct MSGameView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var gameVM: MSGameVM
    
    var closeCallback: ((Error?) -> Void)?
    
    var body: some View {
        VStack {
            
        }
        .onReceive(gameVM.timer) { _ in gameVM.timerAction() }
        .navigationTitle(gameVM.stringTime)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button(
                    action: { gameVM.closeAction() },
                    label: { MSImages.system(.close).image }
                )
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(
                    action: { gameVM.pauseAction() },
                    label: { gameVM.actionBarButton }
                )
                Button(
                    action: { gameVM.menuAction() },
                    label: { MSImages.system(.menu).image }
                )
            }
        }
        .confirmationDialog(
            MSTexts.menu.localized,
            isPresented: $gameVM.showActionSheet,
            actions: {
                Button(
                    action: { gameVM.restartGame() },
                    label: { MSTexts.restartGame.localizedText }
                )
                Button(
                    action: { gameVM.newGame() },
                    label: { MSTexts.newGame.localizedText }
                )
                if gameVM.gameStatus == .lost {
                    Button(
                        action: { close() },
                        label: { MSTexts.close.localizedText }
                    )
                }
            }
        )
        .alert(
            MSTexts.finishGame.localized,
            isPresented: $gameVM.showCloseAlert,
            actions: {
                Button(
                    action: { gameVM.saveGame() },
                    label: { MSTexts.yes.localizedText }
                )
                Button(
                    MSTexts.no.localized,
                    role: .cancel,
                    action: { close() }
                )
            },
            message: { MSTexts.finishGameDisclaimer.localizedText }
        )
//        .alert(
//            MSTexts.info.localized,
//            isPresented: $gameVM.showRanksAlert,
//            actions: {
//                Button(
//                    action: { gameVM.saveRank() },
//                    label: { MSTexts.save.localizedText }
//                )
//                Button(
//                    MSTexts.no.localized,
//                    role: .cancel,
//                    action: { close() }
//                )
//            },
//            message: { gameVM.gameStatus == .won ? MSTexts.gameWon.localizedText : MSTexts.gameLost.localizedText }
//        )
    }
}

private extension MSGameView {
    
    func close(_ error: Error? = nil) {
        closeCallback?(nil)
        dismiss()
    }
}
