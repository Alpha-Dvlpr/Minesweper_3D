//
//  MSGameBoardVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct MSGameBoardVC: View {

    @Environment(\.presentationMode) var presentationMode
    @State private var gameStatus: MSGameStatus = .generating
    @State private var gameTime: Int = 0
    @State private var showActionSheet: Bool = false
    @State private var showBackAlert: (show: Bool, type: MSGameAlertType) = (show: false, type: .idle)
    
    var closeCallback: ((Error?) -> Void)?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var stringTime: String { return MSUtils.getStringTime(seconds: gameTime) }
    private var actionBarButton: Image {
        switch gameStatus {
        case .running: return MSImages.system(.pause).image
        case .paused: return MSImages.system(.play).image
        case .won, .lost: return MSImages.system(.restart).image
        case .generating: return MSImages.system(.timer).image
        case .recurssive: return MSImages.system(.clock).image
        }
    }
    
    var body: some View {
        VStack {
            #if DEBUG
            Text("print cells").onTapGesture { printCurrentFace() }
            #endif
            Text(gameStatus.text.uppercased())
                .bold()
                .foregroundColor(Color.blue)
                .padding()
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
            if gameStatus == .generating {
                // TODO: Add loader
            } else {
                // GameVC(
                //     sideFaces: viewModel.sideFaces,
                //     visibleFace: viewModel.visibleFace,
                //     gameStatus: viewModel.gameStatus,
                //     rotateCallback: { viewModel.rotate($0) },
                //     updateCallback: { viewModel.update(cell: $0, with: $1) { dismissAlertShown = true } }
                // )
            }
            Spacer()
        }
        .onReceive(timer) { _ in if gameStatus == .running { gameTime += 1 } }
        .navigationBarTitle(stringTime, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(
                    action: { showBackAlert = (true, .close) },
                    label: { MSImages.system(.close).image }
                )
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(
                    action: { pauseResumeButtonTapped() },
                    label: { actionBarButton }
                )
                Button(
                    action: { showActionSheet = true },
                    label: { MSImages.system(.menu).image }
                )
            }
        }
        .actionSheet(
            isPresented: $showActionSheet,
            content: {
                ActionSheet(
                    title: MSTexts.menu.localizedText,
                    buttons: [
                        .default(
                            MSTexts.restartGame.localizedText,
                            action: { restartGame() }
                        ),
                        .default(
                            MSTexts.newGame.localizedText,
                            action: { newGame() }
                        ),
                        gameStatus == .lost
                            ? .destructive(MSTexts.close.localizedText, action: { close() })
                            : .cancel(MSTexts.cancel.localizedText)
                    ]
                )
            }
        )
        .alert(isPresented: $showBackAlert.show) {
            switch showBackAlert.type {
            case .idle:
                return Alert(title: Text(""))
            case .close:
                return Alert(
                    title: MSTexts.finishGame.localizedText,
                    message: MSTexts.finishGameDisclaimer.localizedText,
                    primaryButton: .default(MSTexts.yes.localizedText) { saveGame() },
                    secondaryButton: .cancel(MSTexts.no.localizedText) { close() }
                )
            case .ranks:
                return Alert(
                    title: MSTexts.info.localizedText,
                    message: gameStatus == .won ? MSTexts.gameWon.localizedText : MSTexts.gameLost.localizedText,
                    primaryButton: .default(MSTexts.save.localizedText) { saveRank() }, // TODO: Navigate to form to type info
                    secondaryButton: .cancel(MSTexts.close.localizedText) { close() }
                )
            }
        }
    }
}

private extension MSGameBoardVC {
    
    // MARK: - Game functions
//    func rotate(_ direction: Direction) {
//        guard self.gameStatus == .running || self.gameStatus == .lost || self.gameStatus == .won else { return }
//
//        if let linkedFace = self.faces.first(where: { $0.number == self.getReference(for: direction) }) {
//            let aux = linkedFace
//            aux.updateNewReferences(from: self.visibleFace, to: direction)
//            let rotated = aux.rotated
//            rotated.cells.resetCoords()
//
//            self.visibleFace = rotated
//
//            if let visibleSides = self.faces >> (self.visibleFace.references, true) {
//                self.visibleFace.updateVisibleSides(with: visibleSides)
//            }
//
//            self.checkWon()
//        }
//    }
    
//    func update(cell: Cell, with action: Action, loseCallback: @escaping (() -> Void)) {
//        guard self.gameStatus == .running, let aux = self.visibleFace, cell.tappable else { return }
//
//        let x = cell.xCor, y = cell.yCor
//
//        aux.cells.b[y][x].update(with: action) { (updatedCell, status) in
//            switch status {
//            case .running: aux.cells.b[y][x] = updatedCell
//            case .recurssive: aux.recursiveDisplay(from: aux.cells.b[y][x]) { aux.cells.b[$0.yCor][$0.xCor] = $0 }
//            case .lost:
//                self.gameStatus = .lost
//                loseCallback()
//            default: break
//            }
//
//            self.checkWon()
//        }
//    }
    
//    func getReference(for direction: Direction) -> Int {
//        switch direction {
//        case .up: return self.visibleFace.references.top
//        case .down: return self.visibleFace.references.bottom
//        case .left: return self.visibleFace.references.left
//        case .right: return self.visibleFace.references.right
//        }
//    }
    
    // MARK: - TabBar items actions
    func pauseResumeButtonTapped() {
        switch gameStatus {
        case .running: gameStatus = .paused
        case .paused: gameStatus = .running
        default: break
        }
    }
    
    func restartGame() {
        gameTime = 0
//        faces.forEach { $0.cells.hideAllCells() }
        gameStatus = .running
    }
    
    func newGame() {
        gameTime = 0
        gameStatus = .generating
//        generateFaceNumbers()
    }
    
    // MARK: - Game saving functions
    func saveGame() {
//        let coreDataGame = Game(
//            faces: self.faces, visibleFace: self.visibleFace, time: self.gameTime, status: self.gameStatus
//        )
//        CoreDataController.shared.save(game: coreDataGame, completion: completion)
        close(nil)
    }
    
    func saveRank() {
//        with userName: String
//        guard !userName.isEmpty else { return }
//
//        let rank = Rank(name: userName, date: Date(), score: self.calculateGameScore())
//        CoreDataController.shared.save(rank: rank, completion: completion)
        close(nil)
    }
    
    func close(_ error: Error? = nil) {
        closeCallback?(error)
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: - Board functions
//    private func generateFaceNumbers() {
//        let face1 = Face(number: 1, references: References(1, top: 5, bottom: 2, left: 3, right: 4))
//        let face2 = Face(number: 2, references: References(2, top: 1, bottom: 6, left: 3, right: 4))
//        let face3 = Face(number: 3, references: References(3, top: 5, bottom: 2, left: 6, right: 1))
//        let face4 = Face(number: 4, references: References(4, top: 5, bottom: 2, left: 1, right: 6))
//        let face5 = Face(number: 5, references: References(5, top: 6, bottom: 1, left: 3, right: 4))
//        let face6 = Face(number: 6, references: References(6, top: 2, bottom: 5, left: 3, right: 4))
//
//        Updater().updateFaces(
//            faces: FaceT_6(face1, face2, face3, face4, face5, face6)
//        ) { minedFaces in
//            Hinter().calculateHints(faces: minedFaces) { hintedFaces in
//                hintedFaces.i.forEach { $0.cells.disableEditing() }
//
//                self.faces = hintedFaces.i
//                self.visibleFace = self.faces.first(where: { $0.number == 1 })!
//                self.gameStatus = .running
//                self.updateImage()
//            }
//        }
//    }
    
//    private func checkWon() {
//        let totalCells = (MSConstants.numberOfItems ^ 2) * self.faces.count
//        let visibleCells = self.faces
//            .map {
//                $0.cells.b
//                    .map { $0.filter { $0.shown || $0.mined } }
//                    .flatMap { return $0 }
//                    .count
//            }
//            .reduce(0, +)
//
//        if totalCells == visibleCells { self.gameStatus = .won }
//    }
    
//    private func calculateGameScore() -> Int {
//        var score: Double = 0
//
//        self.faces.forEach { face in
//            let visibleCells = face.cells.b
//                .map { $0.filter { $0.shown || $0.flagged || $0.mined } }
//                .flatMap { return $0 }
//            let items = Double(MSConstants.numberOfItems ^ 2)
//            let count = Double(visibleCells.count)
//            let fraction = count / items
//            let multiplyer: Double = 1 + (count == items ? 1 : fraction)
//            var faceScore: Double = 0
//
//            visibleCells.forEach { cell in
//                switch cell.content {
//                case .mine: if cell.isMine { faceScore += 10 }
//                case .number(let number): faceScore += Double(number)
//                case .flagged: if cell.isMine { faceScore += 5 }
//                case .unselected: break
//                case .void: faceScore += 1
//                }
//            }
//
//            faceScore *= multiplyer
//            score += faceScore
//        }
//
//        if self.gameStatus == .won { score += 1500 }
//
//        return Int(score)
//    }
    
    // MARK: - DEBUG functions
    func printCurrentFace() {
//        guard let face = visibleFace else { return }
//        
//        let cells = face.cells.b
//        
//        print("-----------[FACE \(face.number)]-----------")
//        cells.forEach { row in
//            var rowString = ""
//            row.forEach { cell in rowString.append("[\(cell.content.settingKey)]") }
//            rowString.append("\n")
//            print(rowString)
//        }
//        print("------------------------------")
    }
}

struct MSGameBoardVC_Previews: PreviewProvider {
    static var previews: some View {
        MSGameBoardVC { _ in }
    }
}
