//
//  MSAppSate.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 11/05/2021.
//

import SwiftUI

class MSAppState: ObservableObject {
    static let shared = MSAppState()
    
    @Published var gameID = UUID()
}
