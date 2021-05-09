//
//  SettingsVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

class SettingsVM {
    
    var listElements: [SettingsModel] = [
        SettingsModel(
            id: 1,
            title: "user name",
            description: "Alpha Dvlpr"
        ),
        SettingsModel(
            id: 2,
            title: "language",
            description: "Spanish"
        ),
        SettingsModel(
            id: 3,
            title: "auto save ranks",
            description: true
        ),
        SettingsModel(
            id: 4,
            title: "max ranks",
            description: 10
        )
    ]
    
    init() {
        // get elements from core data + save
    }
    
    func deleteData() {
        
    }
    
    func openSettings() {
        let url = URL(string: UIApplication.openSettingsURLString)
        UIApplication.shared.open(url!)
    }
}
