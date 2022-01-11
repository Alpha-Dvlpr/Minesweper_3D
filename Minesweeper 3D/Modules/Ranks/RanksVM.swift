//
//  RanksVM.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 11/01/2022.
//

import Foundation

class RanksVM {
    
    @Published var ranks: [RankModel] = []
    private let coreData = CoreDataController.shared
    private var maxRanks: Int
    
    init() {
        self.maxRanks = self.coreData.getSettingModel(iteration: 0).maxRanks
        self.getRanks()
    }
    
    // MARK: Ranks retrieving
    // ======================
    private func getRanks() {
        self.coreData.getRanks(iteration: 0) {
            if let ranks = $0 {
                let models: [RankModel] = Array(Set(ranks.map { return RankModel(name: $0.name) }))
                    .sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
                
                models.forEach { model in
                    let modelRanks = ranks
                        .filter { rank in rank.name.lowercased() == model.name.lowercased() }
                        .sorted(by: { $0.score > $1.score })
                        .prefix(self.maxRanks)
                        .map { return $0 }
                    model.update(ranks: modelRanks)
                }
                
                self.ranks = models
            }
        }
    }
    
    // MARK: Ranks deletion
    // ====================
    func deleteRanks(completion: @escaping (() -> Void)) {
        self.coreData.deleteSavedRanks()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { completion() }
    }
}
