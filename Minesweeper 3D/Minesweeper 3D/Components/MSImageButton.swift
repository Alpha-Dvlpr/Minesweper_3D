//
//  MSImageButton.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 27/3/24.
//

import SwiftUI

struct MSImageButton: View {
    
    var title: String = ""
    var image: MSImages
    
    var body: some View {
        HStack(spacing: 10) {
            Spacer().frame(width: 1)
            image.image
                .resizable()
                .padding(1)
                .frame(width: 20, height: 20)
                .foregroundStyle(.white)
            Spacer().frame(width: 4)
            Text(title.uppercased())
                .bold()
                .foregroundStyle(.white)
                .frame(alignment: .leading)
            Spacer()
        }
        .padding()
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 16)
    }
}
