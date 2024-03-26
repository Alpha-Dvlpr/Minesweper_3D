//
//  Minesweeper_3DApp.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI

@main
struct Minesweeper_3DApp: App {
    
    @StateObject var appState = MSAppState.shared
    
    var body: some Scene {
        WindowGroup {
            MSMainView().id(appState.gameID)
        }
    }
}
