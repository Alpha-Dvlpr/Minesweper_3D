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
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: SettingsVC()) {
                        Images.settings.system
                            .resizable()
                            .padding(1)
                            .frame(width: 32, height: 32)
                    }
                }
                Spacer()
                VStack(spacing: 10) {
                    NavigationLink(destination: GameBoardVC()) {
                        ImageButton(
                            title: Texts.newGame.localized,
                            image: .play
                        )
                    }
                    NavigationLink(destination: Text("Destination")) {
                        ImageButton(
                            title: Texts.bestMarks.localized,
                            image: .rank
                        )
                    }
                }
                Spacer()
            }
            .padding(self.screenEdges)
            .navigationTitle(Texts.main.localized)
            .navigationBarHidden(true)
        }
    }
}

struct MainVC_Previews: PreviewProvider {
    static var previews: some View {
        MainVC()
    }
}
