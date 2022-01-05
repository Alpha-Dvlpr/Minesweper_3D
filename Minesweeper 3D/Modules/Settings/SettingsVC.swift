//
//  SettingsVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct SettingsVC: View, KeyboardListener {
    
    @ObservedObject private var viewModel = SettingsVM()
    @State private var showDeleteAlert: Bool = false
    @State private var isKeyboardVisible: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text(Texts.general.localized)) {
                HStack(spacing: 15) {
                    Text(Texts.username.localized.uppercased())
                        .foregroundColor(self.viewModel.settings.invalidData ? Color.red : nil)
                    TextField(
                        Texts.username.localized.uppercased(),
                        text: self.$viewModel.settings.username
                    )
                    .multilineTextAlignment(.trailing)
                    .onReceive(
                        self.publisher,
                        perform: { self.isKeyboardVisible = $0 }
                    )
                }
                HStack(spacing: 15) {
                    Text(Texts.language.localized.uppercased())
                    Spacer()
                    Picker("", selection: self.$viewModel.settings.appLanguage) {
                        ForEach(Language.allCases) { Text($0.name.uppercased()).tag($0) }
                    }
                    .frame(width: 100)
                }
//                Toggle(
//                    Texts.autosaveRanks.localized.uppercased(),
//                    isOn: self.$viewModel.settings.autosaveRanks
//                )
//                Stepper(value: self.$viewModel.settings.maxRanks, in: 10...30) {
//                    Text("\(Texts.maxRanks.localized.uppercased()): \(self.$viewModel.settings.maxRanks.wrappedValue)")
//                }
            }
            Section(header: Text(Texts.info.localized)) {
                Text(Texts.version.localized(with: [self.viewModel.appVersion]))
                Text(Texts.copyright.localized)
//                Link(Texts.moreInfo.localized, destination: self.viewModel.infoURL)
            }
            Section(header: Text(Texts.advanced.localized)) {
                Button(
                    action: { self.showDeleteAlert = true  },
                    label: { Text(Texts.deleteTitle.localized) }
                )
                .foregroundColor(Color.red)
            }
        }
        .font(.caption)
        .navigationBarTitle(
            Text(Texts.settings.localized.uppercased()),
            displayMode: .inline
        )
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if self.isKeyboardVisible {
                    Button(
                        action: { self.hideKeyboard() },
                        label: { Images.system(.closeKeyboard).image }
                    )
                }
                if self.viewModel.settingsChanged {
                    Button(
                        action: { self.viewModel.saveData() },
                        label: { Text(Texts.save.localized) }
                    )
                }
            }
        }
        .alert(
            isPresented: self.$showDeleteAlert,
            content: {
                Alert(
                    title: Text(Texts.deleteTitle.localized.uppercased()),
                    message: Text(Texts.deleteDisclaimer.localized),
                    primaryButton: .cancel(
                        Text(Texts.cancel.localized),
                        action: { self.showDeleteAlert = false })
                    ,
                    secondaryButton: .destructive(
                        Text(Texts.delete.localized),
                        action: {
                            self.viewModel.deleteData()
                            self.showDeleteAlert = false
                        }
                    )
                )
            }
        )
    }
}

struct SettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        SettingsVC()
    }
}
