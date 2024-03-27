//
//  MSSettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI
import RealmSwift

class MSSettingsVM: ObservableObject {
    
    @Published var settings: MSSettings!
    
    var alert: Alert {
        return Alert(
            title: MSTexts.deleteTitle.localizedText,
            message: MSTexts.deleteDisclaimer.localizedText,
            primaryButton: .default(MSTexts.cancel.localizedText),
            secondaryButton: .destructive(MSTexts.delete.localizedText) { self.deleteData() }
        )
    }
    
    var stepperString: Text {
        var stringValue = MSTexts.maxRanks.localized
        stringValue.append(": \(settings.maxRanks)")
        
        return Text(stringValue)
    }
    
    var appVersion: Text {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-"
        
        return MSTexts.version.localizedText(with: [ "\(version) (\(build))" ])
    }
    
    var missingData: Int { return settings.getMissingData() }
    
    init() {
        getSettings()
    }
    
    func getSettings() {
        let existing = MSRealmManager.shared.getSettings().freeze()
        let newSettings = MSSettings(
            username: existing.username,
            appLanguage: existing.appLanguage,
            autosaveRanks: existing.autosaveRanks,
            maxRanks: existing.maxRanks
        )
        
        settings = newSettings
    }
    
    func deleteData() {
        MSRealmManager.shared.deleteAllData()
    }
    
    func updateSettings() {
        let realmSettings = RealmSettings(settings: settings)
        
        MSRealmManager.shared.updateSettings(realmSettings)
    }
}
