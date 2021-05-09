//
//  SettingsListCell.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct SettingsListCell: View {
    
    var data: SettingsModel
    
    var body: some View {
        HStack(spacing: 10) {
            Text(data.title.uppercased())
                .bold()
                .multilineTextAlignment(.leading)
                .font(.callout)
            Spacer()
            
            if let stringValue = self.data.value as? String {
                Text(stringValue.uppercased())
                    .multilineTextAlignment(.trailing)
                    .font(.caption)
            } else if let integerValue = self.data.value as? Int {
                Text("\(integerValue)")
                    .multilineTextAlignment(.trailing)
                    .font(.caption)
            } else if let boolValue = self.data.value as? Bool {
                Toggle("", isOn: Binding<Bool>.constant(boolValue))
                    .frame(width: 60)
            } else {
                Text("")
            }
            
            Spacer()
                .frame(width: 8)
            Images.cellArrow.system
                .resizable()
                .frame(width: 8, height: 16)
        }
        .frame(height: 50)
    }
}

struct SettingsListCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListCell(
            data: SettingsModel(
                id: 54,
                title: "cell title",
                value: "^_^"
            )
        )
    }
}
