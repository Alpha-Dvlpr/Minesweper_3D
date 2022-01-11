//
//  MainVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct MainVC: View {
    
    private var screenEdges = EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
    private var viewModel = MainVM()
    @State private var selection: Navigations?
    @State private var saveErrorAlertShown: Bool = false
    @State private var canPerformActions: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    NavigationLink(
                        destination: SettingsVC(),
                        tag: Navigations.settings,
                        selection: self.$selection
                    ) { EmptyView() }
                    NavigationLink(
                        destination: GameBoardVC(
                            viewModel: GameBoardVM(calculate: self.selection == Navigations.game),
                            closeCallback: { self.closeGameAction(with: $0) }
                        ),
                        tag: Navigations.game,
                        selection: self.$selection
                    ) { EmptyView() }
                    NavigationLink(
                        destination: GameBoardVC(
                            viewModel: GameBoardVM(with: self.viewModel.savedGame),
                            closeCallback: { self.closeGameAction(with: $0) }
                        ),
                        tag: Navigations.gameResume,
                        selection: self.$selection
                    ) { EmptyView() }
                    NavigationLink(
                        destination: RanksVC(closeCallback: { self.selection = nil }),
                        tag: Navigations.ranks,
                        selection: self.$selection
                    ) { EmptyView() }
                    //                NavigationLink(
                    //                    destination: ShopVC(),
                    //                    tag: Navigations.shop,
                    //                    selection: self.$selection
                    //                ) { EmptyView() }
                    
                    HStack {
                        Spacer()
                        Button(
                            action: { if self.canPerformActions { self.selection = Navigations.settings } },
                            label: {
                                Images.system(.settings).image
                                    .resizable()
                                    .frame(width: 32, height: 32)
                            }
                        )
                    }
                    Spacer()
                    ImageButton(
                        title: Texts.newGame.localized,
                        image: .system(.play)
                    )
                    .onTapGesture {
                        if self.canPerformActions {
                            self.selection = Navigations.game
                            self.viewModel.deleteGame()
                        }
                    }
                    if let game = self.viewModel.savedGame {
                        ImageButton(
                            title: String(format: Texts.resumeGame.localized, Utils.getStringTime(seconds: game.time)),
                            image: .system(.play)
                        )
                        .onTapGesture { if self.canPerformActions { self.selection = Navigations.gameResume } }
                    }
                    ImageButton(
                        title: Texts.bestMarks.localized,
                        image: .system(.rank)
                    )
                    .onTapGesture { if self.canPerformActions { self.selection = Navigations.ranks } }
                    //                ImageButton(
                    //                    title: Texts.shop.localized,
                    //                    image: .system(.cart)
                    //                )
                    //                .onTapGesture { if self.canPerformActions { self.selection = Navigations.shop } }
                    Spacer()
                }
                if self.saveErrorAlertShown { self.generateSavingErrorAlert() }
            }
            .padding(self.screenEdges)
            .navigationBarTitle(
                Text(Texts.main.localized.uppercased()),
                displayMode: .inline
            )
            .navigationBarHidden(true)
        }
    }
    
    private func closeGameAction(with error: Error?) {
        self.selection = nil
        guard let error = error else { self.viewModel.getSavedGame(); return }
        
        self.canPerformActions = false
        self.viewModel.updateError(error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { self.saveErrorAlertShown = true }
    }
    
    private func generateSavingErrorAlert() -> CustomAlert {
        return CustomAlert(
            showInput: false,
            title: Texts.info.localized,
            message: Texts.errorSavingGame.localized,
            positiveButtonTitle: Texts.close.localized,
            positiveButtonAction: { _ in self.canPerformActions = true }
        )
    }
}

struct MainVC_Previews: PreviewProvider {
    static var previews: some View {
        MainVC()
    }
}
