//
//  MSSettingsView.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI

struct MSSettingsView: View {
    
    @ObservedObject var settingsVM: MSSettingsVM
    @FocusState private var nameFieldfocused: Bool
    @State private var isAlertShown: Bool = false
    
    var body: some View {
        Form {
            Section(header: MSTexts.general.localizedText) {
                HStack(spacing: 15) {
                    MSTexts.username.localizedText
                        .foregroundStyle(settingsVM.settings.isValidName() ? .black : .red)
                    TextField(
                        MSTexts.username.localized,
                        text: $settingsVM.settings.username
                    )
                    .multilineTextAlignment(.trailing)
                    .focused($nameFieldfocused)
                }
                Picker(MSTexts.language.localized, selection: $settingsVM.settings.appLanguage) {
                    ForEach(MSLanguageType.allCases) {
                        Text($0.name).tag($0.code)
                    }
                }
                Toggle(
                    MSTexts.autosaveRanks.localized,
                    isOn: $settingsVM.settings.autosaveRanks
                )
                Stepper(
                    value: $settingsVM.settings.maxRanks,
                    in: MSConstants.maxRanksRange
                ) { settingsVM.stepperString }
            }
            Section(header: MSTexts.info.localizedText) {
                settingsVM.appVersion
                Text("© 2024. Aarón Granado Amores.")
            }
            Section(header: MSTexts.advanced.localizedText) {
                Button(
                    action: { isAlertShown = true },
                    label: { MSTexts.deleteTitle.localizedText }
                ).foregroundStyle(.red)
            }
        }
        .font(.caption)
        .navigationTitle(MSTexts.settings.localizedText)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                if nameFieldfocused {
                    Button(
                        action: { nameFieldfocused = false },
                        label: { MSImages.system(.closeKeyboard).image }
                    )
                }
                Button(
                    action: { settingsVM.updateSettings() },
                    label: { MSTexts.save.localizedText }
                )
            }
        }
        .alert(
            MSTexts.deleteTitle.localized,
            isPresented: $isAlertShown,
            actions: {
                Button(
                    MSTexts.delete.localized,
                    role: .destructive,
                    action: { settingsVM.deleteData() }
                )
            },
            message: { MSTexts.deleteDisclaimer.localizedText }
        )
    }
}
