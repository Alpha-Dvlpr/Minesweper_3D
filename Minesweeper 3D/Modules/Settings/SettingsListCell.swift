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
            
            switch self.data.key {
            case .username:
                Text((self.data.value as? String ?? "").uppercased())
                    .multilineTextAlignment(.trailing)
                    .font(.caption)
            case .language:
                let language = self.data.value as? Language ?? .spanish(.es)
                Text(language.name.uppercased())
                    .multilineTextAlignment(.trailing)
                    .font(.caption)
            case .maxNumberOfRanks:
                Text("\(self.data.value as? Int ?? 0)")
                    .multilineTextAlignment(.trailing)
                    .font(.caption)
            case .autosaveRanks:
                Toggle("", isOn: Binding<Bool>.constant(self.data.value as? Bool ?? false))
                    .frame(width: 60)
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
            data: SettingsModel(value: "^_^")
        )
    }
}
