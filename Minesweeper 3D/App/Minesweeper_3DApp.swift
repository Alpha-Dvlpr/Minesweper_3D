//
//  Minesweeper_3DApp.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

@main
struct Minesweeper_3DApp: App {
    
    @StateObject var appState = MSAppState.shared
    
    var body: some Scene {
        WindowGroup {
            MSMainVC().id(appState.gameID)
        }
    }
}

struct Minesweeper_3DApp_Previews: PreviewProvider {
    static var previews: some View {
        MSMainVC()
    }
}
