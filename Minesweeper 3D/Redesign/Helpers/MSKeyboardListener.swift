//
//  MSKeyboardListener.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 25/5/21.
//

import Combine
import SwiftUI

protocol MSKeyboardListener {
    var publisher: AnyPublisher<Bool, Never> { get }
}

extension MSKeyboardListener {
    var publisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification).map { _ in true },
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification).map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}
