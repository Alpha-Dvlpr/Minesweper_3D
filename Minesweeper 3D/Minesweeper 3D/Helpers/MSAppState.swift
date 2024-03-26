//
//  MSAppState.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI

class MSAppState: ObservableObject {
    
    static let shared = MSAppState()
    
    @Published var gameID = UUID()
    
    func restart() { gameID = UUID() }
}
