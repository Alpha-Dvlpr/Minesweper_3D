//
//  MSSettingsImage.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI

struct MSSettingsImage: View {
    
    var number: Int
    
    var body: some View {
        if number == 0 {
            MSImages.system(.settings).image
        } else {
            MSImages.system(.settings).image
                .overlay(
                    MSImages.numbers(number).image
                        .resizable()
                        .background(.white)
                        .clipShape(Circle())
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.red),
                    alignment: .topTrailing
                )
        }
    }
}
