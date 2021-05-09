//
//  SettingsVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct SettingsVC: View {
    
    @State private var viewModel = SettingsVM()
    
    var body: some View {
        VStack {
            List(self.viewModel.listElements, id: \.id) { data in
                SettingsListCell(data: data)
                    .onTapGesture { self.viewModel.openSettings() }
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
                .onTapGesture { self.viewModel.alertVisible = true }
        )
        .alert(isPresented: self.viewModel.$alertVisible) {
            Alert(
                title: Text(Texts.deleteTitle.localized.uppercased()),
                message: Text(Texts.deleteDisclaimer.localized),
                primaryButton: .destructive(
                    Text(Texts.delete.localized),
                    action: { self.viewModel.alertVisible = false }
                ),
                secondaryButton: .cancel(
                    Text(Texts.cancel.localized),
                    action: { self.viewModel.alertVisible = false }
                )
            )
        }
    }
}

struct SettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        SettingsVC()
    }
}
