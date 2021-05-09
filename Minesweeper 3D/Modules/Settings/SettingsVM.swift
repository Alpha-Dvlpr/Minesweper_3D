//
//  SettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

class SettingsVM {
    
    var listElements: [SettingsModel] = []
    
    var coreDataController = CoreDataController.shared
    
    init() {
        self.getAllData()
    }
    
    private func getAllData() {
        self.listElements = []
        
        SettingKey.allCases.forEach {
            let key = CoreDataKey.settings(key: $0)
            if let model = self.coreDataController.getValkue(for: key) as? SettingsModel {
                self.listElements.append(model)
            }
            
            var count = 1
            self.listElements = self.listElements.map {
                var newElement = $0
                newElement.id = count
                count += 1
                return newElement
            }
        }
    }
    
    func modify(value: Any, for key: SettingKey) {
        if let index = self.listElements.firstIndex(where: { $0.key == key }) {
            self.listElements[index].description = value
        }
    }
    
    func deleteData() {
        self.coreDataController.deleteAllData()
        self.getAllData()
    }
    
//    func openSettings() {
//        let url = URL(string: UIApplication.openSettingsURLString)
//        UIApplication.shared.open(url!)
//    }
}
