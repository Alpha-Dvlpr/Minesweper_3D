//
//  RanksVC.swift
//  Minesweeper 3D
//
//  Created by Aaron on 18/7/21.
//

import SwiftUI

struct RanksVC: View {
    
    @State var showDeleteAlert: Bool = false
    
    private let viewModel = RanksVM()
    var closeCallback: (() -> Void)?
    
    var body: some View {
        ZStack {
            List {
                ForEach(self.viewModel.ranks) { section in
                    Section(header: Text(section.name).font(.headline)) {
                        ForEach(section.ranks, id: \.self) { self.generateCell(for: $0) }
                    }
                }
            }
            
            if self.showDeleteAlert { self.generateDeleteWarningAlert() }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(
            Text(Texts.bestMarks.localized.uppercased()),
            displayMode: .inline
        )
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if !self.viewModel.ranks.isEmpty {
                    Button(
                        action: { self.showDeleteAlert = true },
                        label: { Images.system(.trash).image }
                    )
                }
            }
        }
    }
    
    private func generateDeleteWarningAlert() -> CustomAlert {
        return CustomAlert(
            showInput: false,
            title: Texts.deleteRanksTitle.localized,
            message: Texts.deleteRanksDisclaimer.localized,
            positiveButtonTitle: Texts.cancel.localized,
            negativeButtonTitle: Texts.delete.localized,
            positiveButtonAction: { _ in self.showDeleteAlert = false },
            negativeButtonAction: { self.viewModel.deleteRanks { self.closeCallback?() } }
        )
    }
    
    private func generateCell(for rank: Rank) -> some View {
        return RankCell(rank: rank)
            .swipeActions(
                trailing: [
                    SwipeButton(
                        icon: Images.system(.share).image,
                        action: { Social.shared.share(rank: rank) },
                        tint: .blue
                    )
                ] 
            )
    }
}

struct RanksVC_Previews: PreviewProvider {
    static var previews: some View {
        RanksVC()
    }
}
