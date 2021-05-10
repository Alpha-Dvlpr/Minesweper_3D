//
//  SettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

class SettingsVM: ObservableObject {
        
    @Published var listElements = [SettingsModel]()
    private var coreData = CoreDataController.shared
    private var alerts = CustomAlerts.shared
    
    init() {
        self.getAllData()
    }
    
    func showDeleteAlert() {
        self.alerts.showDeleteAlert { self.deleteData() }
    }
    
    func showInputAlert(for data: SettingsModel) {
        switch data.key {
        case .username, .maxNumberOfRanks:
            self.alerts.showInputAlert(
                title: data.title,
                message: Texts.typeNewValue.localized,
                placeholder: data.title,
                value: data.value,
                keyboardType: data.key == .maxNumberOfRanks ? .numberPad : .asciiCapable,
                firstButtonAction: {
                    guard let callbackData = $0 else { return }
                    
                    if data.key == .maxNumberOfRanks {
                        if let integerValue = Int(callbackData) {
                            self.coreData.saveSetting(integer: integerValue, for: .maxNumberOfRanks)
                        }
                    } else { self.coreData.saveSetting(string: callbackData, for: .username) }
                    
                    self.getAllData()
                }
            )
        case .language:
            self.alerts.showListAlert(
                title: Texts.language.localized,
                language: data.value as? Language ?? .spanish(.es),
                firstButtonAction: {
                    self.coreData.saveSetting(language: $0)
                    self.getAllData()
                }
            )
        case .autosaveRanks:
            let boolValue = data.value as? Bool ?? false
            
            self.alerts.showToggleAlert(
                title: data.title,
                value: boolValue,
                firstButtonAction: {
                    self.coreData.saveSetting(bool: !boolValue, for: .autosaveRanks)
                    self.getAllData()
                }
            )
        }
    }
    
    private func getAllData() {
        self.listElements = []
        
        SettingKey.allCases.forEach {
            let model = self.coreData.getSettingModel(for: $0)
            self.listElements.append(model)
        }
    }
    
    private func deleteData() {
        self.coreData.deleteAllData()
        self.getAllData()
    }
}
