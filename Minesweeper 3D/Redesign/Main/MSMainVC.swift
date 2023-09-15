//
//  MSMainVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 30/6/23.
//

import SwiftUI

struct MSMainVC: View {
    
    private var viewModel = MSMainVM()
    @State private var canPerformActions: Bool = true
    @State private var saveErrorAlertShown: Bool = false
    @State private var selection: MSNavigations?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    NavigationLink(
                        value: MSNavigations.game,
                        label: { MSImageButton(title: Texts.newGame.localized, image: .system(.play)) }
                    ).onTapGesture { viewModel.deleteGame() }
                    if let game = self.viewModel.savedGame {
                        NavigationLink(
                            value: MSNavigations.gameResume,
                            label: {
                                MSImageButton(
                                    title: String(
                                        format: Texts.resumeGame.localized,
                                        Utils.getStringTime(seconds: game.time)
                                    ),
                                    image: .system(.play)
                                )
                            }
                        )
                    }
//                    NavigationLink(
//                        value: MSNavigations.ranks,
//                        label: { MSImageButton(title: Texts.bestMarks.localized, image: .system(.rank)) }
//                    )
//                    NavigationLink(
//                        value: MSNavigations.shop,
//                        label: { MSImageButton(title: Texts.shop.localized, image: .system(.cart)) }
//                    )
                }
                if saveErrorAlertShown { generateSavingErrorAlert() }
            }
            .toolbar {
                NavigationLink(
                    value: MSNavigations.settings,
                    label: {
                        if viewModel.settings.invalidData {
                            settingsImage()
                        } else {
                            Images.system(.settings).image
                        }
                    }
                )
            }
            .navigationDestination(for: MSNavigations.self) { value in
                switch value {
                case .settings:
                    SettingsVC() { viewModel.updateSettings() }
                case .game:
                    GameBoardVC(
                        viewModel: GameBoardVM(calculate: selection == .game),
                        closeCallback: { closeGameAction(with: $0) }
                    )
                case .gameResume:
                    GameBoardVC(
                        viewModel: GameBoardVM(with: viewModel.savedGame),
                        closeCallback: { closeGameAction(with: $0) }
                    )
                case .ranks:
                    RanksVC(closeCallback: { selection = nil })
                case .shop:
                    ShopVC()
                }
            }
            .navigationTitle(Texts.main.localized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func settingsImage() -> some View {
        return Images.system(.settings).image
            .overlay(
                Images.numbers(1).image
                    .resizable()
                    .background(Color.white)
                    .clipShape(Circle())
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.red),
                alignment: .topTrailing
            )
    }
    
    private func closeGameAction(with error: Error?) {
        selection = nil
        
        guard let error = error else { viewModel.getSavedGame(); return }
        
        canPerformActions = false
        viewModel.updateError(error)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { saveErrorAlertShown = true }
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

struct MSMainVC_Previews: PreviewProvider {
    static var previews: some View {
        MSMainVC()
    }
}
