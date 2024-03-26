//
//  MSMainView.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI

struct MSMainView: View {
    
    @ObservedObject var settingsVM = MSSettingsVM()
    @ObservedObject var mainVM = MSMainVM()
 
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .toolbar {
                NavigationLink(
                    value: MSNavigations.settings,
                    label: { MSSettingsImage(number: settingsVM.missingData) }
                )
            }
            .navigationDestination(for: MSNavigations.self) { value in
                switch value {
                case .settings:
                    MSSettingsView(settingsVM: settingsVM)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
