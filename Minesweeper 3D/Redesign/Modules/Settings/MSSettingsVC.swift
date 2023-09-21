//
//  MSSettingsVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI
import RealmSwift

struct MSSettingsVC: View, MSKeyboardListener {
    
    @ObservedRealmObject var settings: MSSettings = MSSettings.empty()
    @State private var showDeleteAlert: Bool = false
    @State private var isKeyboardVisible: Bool = false
    
    private var stepperString: String {
        var stringValue = MSTexts.maxRanks.localized
        stringValue.append(": \(settings.maxRanks)")
        
        return stringValue
    }
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "_"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "_"
        
        return "\(version) (\(build))"
    }
    
    var body: some View {
        Form {
            Section(header: MSTexts.general.localizedText) {
                HStack(spacing: 15) {
                    MSTexts.username.localizedText
                        .foregroundColor(settings.isNameValid() ? nil : Color.red)
                    TextField(
                        MSTexts.username.localized,
                        text: $settings.username
                    )
                    .multilineTextAlignment(.trailing)
                    .onReceive(publisher, perform: { isKeyboardVisible = $0 })
                }
                Picker(MSTexts.language.localized, selection: $settings.appLanguage) {
                    ForEach(MSLanguageType.allCases) {
                        Text($0.name).tag($0.code)
                    }
                }
                Toggle(
                    MSTexts.autosaveRanks.localized,
                    isOn: $settings.autosaveRanks
                )
                Stepper(
                    value: $settings.maxRanks,
                    in: MSConstants.maxRanksRange
                ) { Text(stepperString) }
            }
            Section(header: Text(MSTexts.info.localized)) {
                MSTexts.version.localizedText(with: [appVersion])
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
                Button(
                    action: { updateSettings() },
                    label: { MSTexts.save.localizedText }
                )
            }
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: MSTexts.deleteTitle.localizedText,
                message: MSTexts.deleteDisclaimer.localizedText,
                primaryButton: .default(MSTexts.cancel.localizedText),
                secondaryButton: .destructive(MSTexts.delete.localizedText) { deleteData() }
            )
        }
        .onAppear { getSettings() }
    }
}

extension MSSettingsVC {
    
    func deleteData() {
        MSRealmManaager.shared.deleteAllData()
    }
    
    func getSettings() {
        let newSettings = MSRealmManaager.shared.getSetings().freeze()
        
        $settings.username.wrappedValue = newSettings.username
        $settings.appLanguage.wrappedValue = newSettings.appLanguage
        $settings.autosaveRanks.wrappedValue = newSettings.autosaveRanks
        $settings.maxRanks.wrappedValue = newSettings.maxRanks
    }
    
    func updateSettings() {
        MSRealmManaager.shared.updateSettings(settings)
    }
}

struct SettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        MSSettingsVC(settings: MSSettings.empty())
    }
}
