//
//  MSSettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI
import RealmSwift

class MSSettingsVM: ObservableObject {
    
    @ObservedRealmObject var settings = MSSettings.empty()
    @Published var isAlertShown: Bool = false
    
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
    
    func showAlert() {
        isAlertShown = true
    }
    
    func updateSettings() {
        MSRealmManager.shared.updateSettings(settings)
    }
}

private extension MSSettingsVM {
    
    func deleteData() {
        MSRealmManager.shared.deleteAllData()
    }
    
    func getSettings() {
        settings = MSRealmManager.shared.getSettings().freeze()
    }
}
