//
//  MSMainVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 30/6/23.
//

import SwiftUI

struct MSMainVC: View {
    
    @State private var saveErrorAlertShown: Bool = false
    @State private var selection: MSNavigations?
    @State private var missingData: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(
                    value: MSNavigations.game,
                    label: { MSImageButton(title: MSTexts.newGame.localized, image: .system(.play)) }
                ).onTapGesture { deleteGame() }
            }
            .toolbar {
                NavigationLink(
                    value: MSNavigations.settings,
                    label: {
                        if missingData != 0 {
                            MSSettingsImage(number: missingData)
                        } else {
                            MSImages.system(.settings).image
                        }
                    }
                )
            }
            .navigationDestination(for: MSNavigations.self) { value in
                switch value {
                case .settings:
                    MSSettingsVC()
                case .game:
                    Text("game")
                case .gameResume:
                    Text("saved game")
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $saveErrorAlertShown) {
                Alert(
                    title: MSTexts.info.localizedText,
                    message: MSTexts.errorSavingGame.localizedText,
                    dismissButton: .default(MSTexts.cancel.localizedText)
                )
            }.onAppear { getMissingSettings() }
        }
    }
}

extension MSMainVC {
        
    private func deleteGame() {
        
    }
    
    private func getMissingSettings() {
        missingData = MSRealmManaager.shared.getSetings().freeze().getMissingData()
    }
}

struct MSMainVC_Previews: PreviewProvider {
    static var previews: some View {
        MSMainVC()
    }
}
