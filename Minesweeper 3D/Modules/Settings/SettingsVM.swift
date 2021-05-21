//
//  SettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

class SettingsVM: ObservableObject {
    
    @Published var settings: Settings!
        
    private var coreData = CoreDataController.shared
    
    init() {
        self.getAllData()
    }
    
    func saveData() {
        self.coreData.save(settings: self.settings)
    }
    
    func deleteData() {
        self.coreData.deleteAllData()
        self.getAllData()
    }
    
    private func getAllData() {
        self.settings = self.coreData.getSettingModel(iteration: 0)
    }
}
