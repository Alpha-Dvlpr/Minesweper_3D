//
//  SettingsVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct SettingsVC: View {
    
    @ObservedObject private var viewModel = SettingsVM()
    
    var body: some View {
        VStack {
            List(self.viewModel.listElements) { data in
                SettingsListCell(data: data)
                    .onTapGesture { self.viewModel.showInputAlert(for: data) }
            }
            Spacer()
        }
        .navigationBarTitle(
            Text(Texts.settings.localized.uppercased()),
            displayMode: .inline
        )
        .navigationBarItems(
            trailing:
                Images.trash.system
                .foregroundColor(.red)
                .onTapGesture { self.viewModel.showDeleteAlert() }
        )
    }
}

struct SettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        SettingsVC()
    }
}
