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
    private var stepperString: String {
        var stringValue = Texts.maxRanks.localized.uppercased()
        stringValue.append(": \(self.$viewModel.settings.maxRanks.wrappedValue)")
        return stringValue
    }
    
    var body: some View {
        ZStack {
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
                    Toggle(
                        Texts.autosaveRanks.localized.uppercased(),
                        isOn: self.$viewModel.settings.autosaveRanks
                    )
                    Stepper(
                        value: self.$viewModel.settings.maxRanks,
                        in: Constants.maxRanksRange
                    ) { Text(self.stepperString) }
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
            
            if self.showDeleteAlert { self.generateDeleteAlert() }
        }
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
    }
    
    private func generateDeleteAlert() -> CustomAlert {
        return CustomAlert(
            showInput: false,
            title: Texts.deleteTitle.localized,
            message: Texts.deleteDisclaimer.localized,
            positiveButtonTitle: Texts.cancel.localized,
            negativeButtonTitle: Texts.delete.localized,
            positiveButtonAction: { _ in self.showDeleteAlert = false },
            negativeButtonAction: {
                self.viewModel.deleteData()
                self.showDeleteAlert = false
            }
        )
    }
}

struct SettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        SettingsVC()
    }
}
