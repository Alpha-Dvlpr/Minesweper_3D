//
//  CoreDataController.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import Foundation

class CoreDataController {
    static let shared = CoreDataController()
    
    // MARK: Saving
    // ============
    func save(settings: Settings) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: settings, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: CoreDataKey.settings.key)
            if settings.languageChanged { self.restart() }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func save(ranks: [Any]) {
        UserDefaults.standard.set(ranks, forKey: CoreDataKey.ranks.key)
    }
    
    // MARK: Retrieving
    // ================
    func getSettingModel(iteration: Int) -> Settings {
        if iteration == 3 { fatalError("Could not get settings") }
        
        let model = Settings(
            username: "",
            appLanguage: nil,
            autosaveRanks: false,
            maxRanks: 15
        )
        
        if let decoded = UserDefaults.standard.object(forKey: CoreDataKey.settings.key) as? Data {
            do {
                let decodedSettings = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? Settings
                return decodedSettings!
            } catch { fatalError(error.localizedDescription) }
        } else {
            self.save(settings: model)
            return self.getSettingModel(iteration: iteration + 1)
        }
    }
    
    func getRanks(for value: Any?) -> String {
        guard let stringValue = value as? String else { return "" }
        return stringValue
    }
    
    // MARK: Deletion
    // ==============
    func deleteAllData() {
        UserDefaults.standard.removeObject(forKey: CoreDataKey.settings.key)
        UserDefaults.standard.removeObject(forKey: CoreDataKey.ranks.key)
        self.restart()
    }
    
    func restart() {
        AppState.shared.gameID = UUID()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//
//        }
    }
}
