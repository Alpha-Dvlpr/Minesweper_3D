//
//  SettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

class SettingsVM: ObservableObject {
    
    @Published var settings: Settings!
    private var originalSettings: Settings!
    var settingsChanged: Bool { return !self.settings.equals(settings: self.originalSettings) }
    var appVersion: String!
    let infoURL = URL(string: "https://www.apple.com/es/iphone")!
        
    private var coreData = CoreDataController.shared
    
    init() {
        self.getAllData()
        self.appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    func saveData() {
        self.coreData.save(
            settings: self.settings,
            reset: self.settings.appLanguage != self.originalSettings.appLanguage
        )
        self.getAllData()
    }
    
    func deleteData() {
        self.coreData.deleteAllData()
        self.getAllData()
    }
    
    private func getAllData() {
        self.settings = self.coreData.getSettingModel(iteration: 0)
        self.originalSettings = self.coreData.getSettingModel(iteration: 0)
    }
}
