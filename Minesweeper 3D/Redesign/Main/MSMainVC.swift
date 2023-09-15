//
//  MSMainVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 30/6/23.
//

import SwiftUI

struct MSMainVC: View {
    
    @StateObject private var viewModel = MSMainVM()
    @State private var saveErrorAlertShown: Bool = false
    @State private var selection: MSNavigations?
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(
                    value: MSNavigations.game,
                    label: { MSImageButton(title: MSTexts.newGame.localized, image: .system(.play)) }
                ).onTapGesture { viewModel.deleteGame() }
            }
            .toolbar {
                NavigationLink(
                    value: MSNavigations.settings,
                    label: {
                        if let errors = viewModel.settings?.getMissingData() {
                            MSSettingsImage(number: errors)
                        } else {
                            MSImages.system(.settings).image
                        }
                    }
                )
            }
            .navigationDestination(for: MSNavigations.self) { value in
                switch value {
                case .settings:
                    MSSettingsVC() { viewModel.updateSettings() }
                case .game:
                    Text("game")
                case .gameResume:
                    Text("saved game")
                }
            }
            .navigationTitle(MSTexts.main.localized)
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $saveErrorAlertShown) {
                Alert(
                    title: MSTexts.info.localizedText,
                    message: MSTexts.errorSavingGame.localizedText,
                    dismissButton: .default(MSTexts.cancel.localizedText)
                )
            }
            .onAppear {
                viewModel.getSavedGame()
                viewModel.updateSettings()
            }
        }
    }
}

struct MSMainVC_Previews: PreviewProvider {
    static var previews: some View {
        MSMainVC()
    }
}
