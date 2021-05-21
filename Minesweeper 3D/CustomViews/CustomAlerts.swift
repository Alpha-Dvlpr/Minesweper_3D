//
//  CustomAlerts.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 10/05/2021.
//

import UIKit
import Bond

class CustomAlerts: NSObject {
    
    static let shared = CustomAlerts()

    func showOptionsMenu(
        newGameButtonAction: @escaping (() -> Void),
        restartButtonAction: @escaping (() -> Void)
    ) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let newGameButton = UIAlertAction(
            title: Texts.newGame.localized,
            style: .default,
            handler: { _ in newGameButtonAction() }
        )
        
        let restartGameButton = UIAlertAction(
            title: Texts.restartGame.localized,
            style: .default,
            handler: { _ in restartButtonAction() }
        )
        
        let cancelAction = UIAlertAction(title: Texts.cancel.localized, style: .cancel, handler: nil)
        
        alert.addAction(restartGameButton)
        alert.addAction(newGameButton)
        alert.addAction(cancelAction)
        
        let controller = UIApplication.shared.windows.first?.rootViewController
        controller?.present(alert, animated: true, completion: nil)
    }
}
