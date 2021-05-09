//
//  SettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

class SettingsVM: ObservableObject {
        
    @Published var listElements = [SettingsModel]()
    var coreDataController = CoreDataController.shared
    
    init() {
        self.getAllData()
    }
    
    func showDeleteAlert() {
        let alert = UIAlertController(
            title: Texts.deleteTitle.localized.uppercased(),
            message: Texts.deleteDisclaimer.localized,
            preferredStyle: .alert
        )
        let firstAction = UIAlertAction(
            title: Texts.delete.localized,
            style: .destructive,
            handler: { _ in self.deleteData() }
        )
        let secondAction = UIAlertAction(
            title: Texts.cancel.localized,
            style: .cancel
        )
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        let controller = UIApplication.shared.windows.first?.rootViewController
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func showInputAlert(for data: SettingsModel) {
        var message: String? = nil
        let addTextField: Bool = data.key != .autosaveRanks
        
        if data.key != .autosaveRanks { message = Texts.typeNewValue.localized }
        else {
            if let bool = data.value as? Bool {
                let actual = Texts.boolToString(value: bool).localized
                let next = Texts.boolToString(value: !bool).localized
                
                message = String.init(
                    format: Texts.currentValueDisclaimer.localized,
                    arguments: [actual, next]
                )
            }
        }
        
        let alert = UIAlertController(
            title: data.title.uppercased(),
            message: message,
            preferredStyle: .alert
        )
        
        let firstAction = UIAlertAction(
            title: Texts.save.localized,
            style: .default,
            handler: { _ in
                self.modify(
                    value: alert.textFields?.first?.text,
                    for: data.key
                )
            }
        )
        
        let secondAction = UIAlertAction(
            title: Texts.cancel.localized,
            style: .cancel
        )
        
        if addTextField {
            alert.addTextField { (field) in
                switch data.key {
                case .username, .language:
                    field.text = data.value as? String
                    field.keyboardType = .default
                case .maxNumberOfRanks:
                    if let integerValue = data.value as? Int {
                        field.text = "\(integerValue)"
                    }
                    
                    field.keyboardType = .numberPad
                default: break
                }
                
                field.placeholder = data.title
                field.clearButtonMode = .whileEditing
            }
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        let controller = UIApplication.shared.windows.first?.rootViewController
        controller?.present(alert, animated: true, completion: nil)
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
    
    private func modify(value: Any?, for key: SettingKey) {
        guard let value = value else { return }
        
        var items: [SettingsModel] = []
        
        self.listElements.forEach {
            if $0.key == key {
                var newItem = $0
                newItem.value = value
                items.append(newItem)
            } else {
                items.append($0)
            }
        }
        
        self.listElements = items
    }
    
    private func deleteData() {
        self.coreDataController.deleteAllData()
        self.getAllData()
    }
}
