//
//  AppSate.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 11/05/2021.
//

import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var gameID = UUID()
}
