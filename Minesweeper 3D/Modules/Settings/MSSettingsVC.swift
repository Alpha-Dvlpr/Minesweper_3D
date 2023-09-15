//
//  MSSettingsVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct MSSettingsVC: View, MSKeyboardListener {
    
    @ObservedObject private var viewModel = MSSettingsVM()
    @State private var showDeleteAlert: Bool = false
    @State private var isKeyboardVisible: Bool = false
    
    private var stepperString: String {
        var stringValue = MSTexts.maxRanks.localized
        stringValue.append(": \($viewModel.settings.maxRanks.wrappedValue)")
        
        return stringValue
    }
    var saveCallback: (() -> Void)?
    
    var body: some View {
        Form {
            Section(header: MSTexts.general.localizedText) {
                HStack(spacing: 15) {
                    MSTexts.username.localizedText
                        .foregroundColor(viewModel.settings.getMissingData() != nil ? Color.red : nil)
                    TextField(
                        MSTexts.username.localized,
                        text: $viewModel.settings.username
                    )
                    .multilineTextAlignment(.trailing)
                    .onReceive(publisher, perform: { isKeyboardVisible = $0 })
                }
                Picker(MSTexts.language.localized, selection: $viewModel.settings.appLanguage) {
                    ForEach(MSLanguage.allCases) {
                        Text($0.name).tag($0)
                    }
                }
                Toggle(
                    MSTexts.autosaveRanks.localized,
                    isOn: $viewModel.settings.autosaveRanks
                )
                Stepper(
                    value: $viewModel.settings.maxRanks,
                    in: MSConstants.maxRanksRange
                ) { Text(stepperString) }
            }
            Section(header: Text(MSTexts.info.localized)) {
                MSTexts.version.localizedText(with: [viewModel.appVersion])
                Text("© 2023. Aarón Granado Amores.")
            }
            Section(header: MSTexts.advanced.localizedText) {
                Button(
                    action: { showDeleteAlert = true  },
                    label: { MSTexts.deleteTitle.localizedText }
                )
                .foregroundColor(Color.red)
            }
        }
        .font(.caption)
        .navigationBarTitle(MSTexts.settings.localizedText, displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if isKeyboardVisible {
                    Button(
                        action: { hideKeyboard() },
                        label: { MSImages.system(.closeKeyboard).image }
                    )
                }
                if viewModel.settingsChanged {
                    Button(
                        action: {
                            viewModel.saveData()
                            saveCallback?()
                        },
                        label: { Text(MSTexts.save.localized) }
                    )
                }
            }
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: MSTexts.deleteTitle.localizedText,
                message: MSTexts.deleteDisclaimer.localizedText,
                primaryButton: .default(MSTexts.cancel.localizedText),
                secondaryButton: .destructive(MSTexts.delete.localizedText) {
                    viewModel.deleteData()
                }
            )
        }
    }
}

struct SettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        MSSettingsVC()
    }
}
