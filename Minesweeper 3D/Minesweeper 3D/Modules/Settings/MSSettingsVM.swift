//
//  MSSettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI

class MSSettingsVM: ObservableObject {
    
    @Published var settings: MSSettings!
    @Published var showDeleteAlert: Bool = false
    
    var stepperString: Text { return Text(MSTexts.maxRanks.localized.appending(": \(settings.maxRanks)")) }
    var missingData: Int { return settings.getMissingData() }
    
    init() { getSettings() }
    
    func getSettings() {
        let existing = MSRealmManager.shared.getSettings().freeze()
        
        settings = MSSettings(
            username: existing.username,
            appLanguage: existing.appLanguage,
            autosaveRanks: existing.autosaveRanks,
            maxRanks: existing.maxRanks
        )
    }
    
    func deleteAction() { showDeleteAlert = true }
    func deleteData() { MSRealmManager.shared.deleteAllData() }
    func updateSettings() { MSRealmManager.shared.updateSettings(RealmSettings(settings: settings)) }
}
