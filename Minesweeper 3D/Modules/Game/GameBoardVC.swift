//
//  GameBoardVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

//struct GameBoardVC: View {
//
//    @ObservedObject var viewModel: GameBoardVM
//    @State private var menuShown: Bool = false
//    @State private var dismissAlertShown: Bool = false
//
//    var closeCallback: ((Error?) -> Void)?
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//    var body: some View {
//        ZStack {
//            VStack {
//            #if DEBUG
//            Text("print cells").onTapGesture { self.viewModel.printCurrentFace() }
//            #endif
//            Text(self.viewModel.gameStatus.text.uppercased())
//                .bold()
//                .foregroundColor(Color.blue)
//                .padding()
//                .font(.title)
//                .multilineTextAlignment(.center)
//            Spacer()
//            if self.viewModel.gameStatus != .generating {
//                GameVC(
//                    sideFaces: self.viewModel.sideFaces,
//                    visibleFace: self.viewModel.visibleFace,
//                    gameStatus: self.viewModel.gameStatus,
//                    rotateCallback: { self.viewModel.rotate($0) },
//                    updateCallback: { self.viewModel.update(cell: $0, with: $1) { self.dismissAlertShown = true } }
//                )
//            }
//            Spacer()
//        }
//            if self.dismissAlertShown {
//                self.viewModel.gameStatus == .lost
//                    ? self.generateSaveRankAlert()
//                    : self.generateCloseAlert()
//            }
//
//            if self.viewModel.gameStatus == .won {
//                self.generateSaveRankAlert(win: true)
//            }
//        }
//        .onReceive(self.timer) { _ in self.viewModel.updateTime() }
//        .navigationBarTitle(
//            self.viewModel.stringTime,
//            displayMode: .inline
//        )
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItemGroup(placement: .navigationBarLeading) {
//                Button(
//                    action: { self.dismissAlertShown = true },
//                    label: { Images.system(.close).image }
//                )
//            }
//        }
//        .toolbar {
//            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                Button(
//                    action: { self.viewModel.pauseResumeButtonTapped() },
//                    label: { self.viewModel.actionBarButton }
//                )
//                Button(
//                    action: { self.menuShown = true },
//                    label: { Images.system(.menu).image }
//                )
//            }
//        }
//        .actionSheet(
//            isPresented: self.$menuShown,
//            content: {
//                ActionSheet(
//                    title: Text(Texts.menu.localized.uppercased()),
//                    buttons: [
//                        .default(
//                            Text(Texts.restartGame.localized),
//                            action: { self.viewModel.restartGame() }
//                        ),
//                        .default(
//                            Text(Texts.newGame.localized),
//                            action: { self.viewModel.newGame() }
//                        ),
//                        self.viewModel.gameStatus == .lost
//                            ? .destructive(Text(Texts.close.localized), action: { self.closeCallback?(nil) })
//                            : .cancel(Text(Texts.cancel.localized))
//                    ]
//                )
//            }
//        )
//    }
//
//    private func generateCloseAlert() -> CustomAlert {
//        return CustomAlert(
//            showInput: false,
//            title: Texts.finishGame.localized,
//            message: Texts.finishGameDisclaimer.localized,
//            positiveButtonTitle: Texts.yes.localized,
//            negativeButtonTitle: Texts.no.localized,
//            positiveButtonAction: { _ in self.viewModel.saveGame { self.closeCallback?($0) } },
//            negativeButtonAction: { self.closeCallback?(nil) }
//        )
//    }
//
//    private func generateSaveRankAlert(win: Bool = false) -> CustomAlert {
//        return CustomAlert(
//            fieldText: self.viewModel.settings.username,
//            showInput: true,
//            title: Texts.info.localized,
//            message: win ? Texts.gameWon.localized : Texts.gameLost.localized,
//            inputPlaceholder: Texts.username.localized,
//            positiveButtonTitle: Texts.save.localized,
//            negativeButtonTitle: Texts.close.localized,
//            positiveButtonAction: {
//                guard let name = $0 as? String else { return }
//                self.viewModel.saveRank(with: name) { self.closeCallback?($0) } },
//            negativeButtonAction: { self.closeCallback?(nil) }
//        )
//    }
//}

//struct GameBoardVC_Previews: PreviewProvider {
//    static var previews: some View {
//        GameBoardVC(viewModel: GameBoardVM(calculate: true), closeCallback: { _ in })
//    }
//}
