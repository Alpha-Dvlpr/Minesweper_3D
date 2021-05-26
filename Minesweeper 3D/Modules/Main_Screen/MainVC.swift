//
//  MainVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct MainVC: View {
    
    private var screenEdges = EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
    @State private var selection: String?
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: SettingsVC(),
                    tag: "settings",
                    selection: self.$selection
                ) { EmptyView() }
                NavigationLink(
                    destination: GameBoardVC(closeCallback: { self.selection = nil }),
                    tag: "game",
                    selection: self.$selection
                ) { EmptyView() }
                NavigationLink(
                    destination: Text("Ranks"),
                    tag: "ranks",
                    selection: self.$selection
                ) { EmptyView() }
                
                HStack {
                    Spacer()
                    Button(
                        action: { self.selection = "settings" },
                        label: {
                            Images.system(.settings).image
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                    )
                }
                Spacer()
                ImageButton(
                    title: Texts.newGame.localized,
                    image: .system(.play)
                )
                .onTapGesture { self.selection = "game" }
                ImageButton(
                    title: Texts.bestMarks.localized,
                    image: .system(.rank)
                )
                .onTapGesture { self.selection = "ranks" }
                Spacer()
            }
            .padding(self.screenEdges)
            .navigationBarTitle(
                Text(Texts.main.localized.uppercased()),
                displayMode: .inline
            )
            .navigationBarHidden(true)
        }
    }
}

struct MainVC_Previews: PreviewProvider {
    static var previews: some View {
        MainVC()
    }
}
