//
//  SettingsListCell.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct SettingsListCell: View {
    
    var title: String
    var details: String
    
    var body: some View {
        HStack {
            Text(title.uppercased())
                .bold()
                .multilineTextAlignment(.leading)
                .font(.callout)
            Spacer()
            Text(details.uppercased())
                .multilineTextAlignment(.trailing)
                .font(.caption)
        }
        .padding()
    }
}

struct Settings_List_Cell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListCell(title: "Cell title", details: "data")
    }
}
