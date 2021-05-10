//
//  Minesweeper_3DApp.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

@main
struct Minesweeper_3DApp: App {
    
    @StateObject var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            MainVC().id(self.appState.gameID)
        }
    }
}

struct Minesweeper_3DApp_Previews: PreviewProvider {
    static var previews: some View {
        MainVC()
    }
}
