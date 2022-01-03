//
//  MainVC.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct MainVC: View {
    
    private var screenEdges = EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
    @State private var selection: Navigations?
    @State private var saveErrorAlertShown: Bool = false
    @State private var canPerformActions: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: SettingsVC(),
                    tag: Navigations.settings,
                    selection: self.$selection
                ) { EmptyView() }
                NavigationLink(
                    destination: GameBoardVC(
                        viewModel: GameBoardVM(calculate: self.selection == Navigations.game),
                        closeCallback: { saved in
                            self.selection = nil
                            if saved == nil {
                                self.canPerformActions = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { self.saveErrorAlertShown = true }
                            }
                        }
                    ),
                    tag: Navigations.game,
                    selection: self.$selection
                ) { EmptyView() }
//                NavigationLink(
//                    destination: RanksVC(),
//                    tag: Navigations.ranks,
//                    selection: self.$selection
//                ) { EmptyView() }
//                NavigationLink(
//                    destination: ShopVC(),
//                    tag: Navigations.shop,
//                    selection: self.$selection
//                ) { EmptyView() }
                
                HStack {
                    Spacer()
                    Button(
                        action: { if self.canPerformActions { self.selection = Navigations.settings } },
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
                .onTapGesture { if self.canPerformActions { self.selection = Navigations.game } }
//                ImageButton(
//                    title: Texts.bestMarks.localized,
//                    image: .system(.rank)
//                )
//                .onTapGesture { if self.canPerformActions { self.selection = Navigations.ranks } }
//                ImageButton(
//                    title: Texts.shop.localized,
//                    image: .system(.cart)
//                )
//                .onTapGesture { if self.canPerformActions { self.selection = Navigations.shop } }
                Spacer()
            }
            .padding(self.screenEdges)
            .navigationBarTitle(
                Text(Texts.main.localized.uppercased()),
                displayMode: .inline
            )
            .navigationBarHidden(true)
        }
        .alert(
            isPresented: self.$saveErrorAlertShown,
            content: {
                Alert(
                    title: Text(Texts.info.localized),
                    message: Text(Texts.errorSavingGame.localized),
                    dismissButton: .default(Text(Texts.close.localized), action: { self.canPerformActions = true })
                )
            }
        )
    }
}

struct MainVC_Previews: PreviewProvider {
    static var previews: some View {
        MainVC()
    }
}
