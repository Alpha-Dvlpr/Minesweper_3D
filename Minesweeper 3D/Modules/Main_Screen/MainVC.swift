//
//  MainVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct MainVC: View {
    
    var screenEdges = EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "gear")
                    .resizable()
                    .padding(1)
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        print("settings button tapped")
                    }
            }
            Spacer()
            VStack(spacing: 10) {
                Image_Button(
                    title: Texts.newGame.localized,
                    imageName: "play",
                    callback: {
                        print("new game button tapped")
                    }
                )
                Image_Button(
                    title: Texts.bestMarks.localized,
                    imageName: "list.star",
                    callback: {
                        print("rank button tapped")
                    }
                )
            }
            Spacer()
        }
        .padding(self.screenEdges)
    }
}

struct MainVC_Previews: PreviewProvider {
    static var previews: some View {
        MainVC()
    }
}
