//
//  SettingsModel.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct SettingsModel: Identifiable {
    var id: Int = 0
    var title: String = ""
    var key: SettingKey = .username
    var value: Any = "nya"
}
