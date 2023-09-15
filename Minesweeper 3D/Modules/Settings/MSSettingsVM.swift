//
//  MSSettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

class MSSettingsVM: ObservableObject {
    
    @Published var settings: MSSettings!
    private var originalSettings: MSSettings!
    var settingsChanged: Bool { return !self.settings.equals(settings: self.originalSettings) }
    var appVersion: String!
//    let infoURL = URL(string: "https://www.apple.com/es/iphone")!
        
    private var coreData = MSCoreDataController.shared
    
    init() {
        self.getAllData()
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "_"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "_"
        
        self.appVersion = "\(version) (\(build))"
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
