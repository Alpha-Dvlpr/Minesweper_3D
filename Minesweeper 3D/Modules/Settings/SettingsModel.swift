//
//  SettingsModel.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct SettingsModel: Identifiable {
    var id: Int { return self.key.id }
    var title: String { return self.key.title }
    var key: SettingKey = .username
    var value: Any = "nya"
}
