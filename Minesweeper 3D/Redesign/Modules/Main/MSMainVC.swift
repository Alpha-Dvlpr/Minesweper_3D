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
    private var missingData: Int { return MSRealmManaager.shared.getSetings().freeze().getMissingData() }
    private var savedGame: Bool { return false }
    
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
                    label: { MSSettingsImage(number: missingData) }
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
            }
        }
    }
}

extension MSMainVC {
        
    private func deleteGame() {
        
    }
}

struct MSMainVC_Previews: PreviewProvider {
    static var previews: some View {
        MSMainVC()
    }
}
