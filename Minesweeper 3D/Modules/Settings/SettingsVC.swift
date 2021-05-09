//
//  SettingsVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct SettingsVC: View {
    
    @State private var viewModel = SettingsVM()
    @State private var alertVisible: Bool = false
    
    var body: some View {
        VStack {
            List(self.viewModel.listElements, id: \.id) {
                SettingsListCell(data: $0)
                    .onTapGesture {  }
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
                .onTapGesture { self.alertVisible = true }
        )
        .alert(isPresented: self.$alertVisible) {
            Alert(
                title: Text(Texts.deleteTitle.localized.uppercased()),
                message: Text(Texts.deleteDisclaimer.localized),
                primaryButton: .destructive(
                    Text(Texts.delete.localized),
                    action: {
                        self.alertVisible = false
                        self.viewModel.deleteData()
                    }
                ),
                secondaryButton: .cancel(
                    Text(Texts.cancel.localized),
                    action: { self.alertVisible = false }
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
