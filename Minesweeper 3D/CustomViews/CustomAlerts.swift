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
    
    private var languages: [Language] = [
        Language.spanish(.es),
        Language.spanish(.ca),
        Language.english
    ]
    private var listAlertFieldValue = Observable<Language>(.spanish(.es))
    
    func showDeleteAlert(deleteAction: @escaping (() -> Void)) {
        let alert = UIAlertController(
            title: Texts.deleteTitle.localized.uppercased(),
            message: Texts.deleteDisclaimer.localized,
            preferredStyle: .alert
        )
        let firstAction = UIAlertAction(
            title: Texts.delete.localized,
            style: .destructive,
            handler: { _ in deleteAction() }
        )
        let secondAction = UIAlertAction(
            title: Texts.cancel.localized,
            style: .cancel
        )
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        let controller = UIApplication.shared.windows.first?.rootViewController
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func showInputAlert(
        title: String,
        message: String,
        placeholder: String,
        value: Any,
        keyboardType: UIKeyboardType = .asciiCapable,
        firstButtonTitle: String = Texts.save.localized,
        firstButtonAction: @escaping ((String?) -> Void) = { _ in },
        secondButtonTitle: String = Texts.cancel.localized,
        secondButtonAction: @escaping (() -> Void) = { }
    ) {
        let alert = UIAlertController(
            title: title.uppercased(),
            message: message,
            preferredStyle: .alert
        )
        
        let firstAction = UIAlertAction(
            title: firstButtonTitle,
            style: .default,
            handler: { _ in firstButtonAction(alert.textFields?.first?.text) }
        )
        
        let secondAction = UIAlertAction(
            title: secondButtonTitle,
            style: .cancel,
            handler: { _ in secondButtonAction() }
        )
    
    alert.addTextField { field in
        if let stringValue = value as? String {
            field.text = stringValue
        } else if let intValue = value as? Int {
            field.text = "\(intValue)"
        }
        
        field.keyboardType = keyboardType
        field.placeholder = placeholder
        field.clearButtonMode = .whileEditing
    }
    
    alert.addAction(firstAction)
    alert.addAction(secondAction)
    
    let controller = UIApplication.shared.windows.first?.rootViewController
    controller?.present(alert, animated: true, completion: nil)
}
    
    func showListAlert(
        title: String,
        language: Language,
        firstButtonTitle: String = Texts.save.localized,
        firstButtonAction: @escaping ((Language) -> Void) = { _ in },
        secondButtonTitle: String = Texts.cancel.localized,
        secondButtonAction: @escaping (() -> Void) = { }
    ) {
        let alert = UIAlertController(
            title: title.uppercased(),
            message: language.name,
            preferredStyle: .alert
        )
        
        let firstAction = UIAlertAction(
            title: firstButtonTitle,
            style: .default,
            handler: { _ in firstButtonAction(self.listAlertFieldValue.value) }
        )
        
        let secondAction = UIAlertAction(
            title: secondButtonTitle,
            style: .cancel,
            handler: { _ in secondButtonAction() }
        )
        
        alert.addTextField { field in
            self.listAlertFieldValue.value = language
            
            let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            
            self.listAlertFieldValue.observeNext { field.text = $0.name.uppercased() }.dispose(in: self.bag)
            
            let row = self.languages.firstIndex(where: { $0 == language }) ?? 0
            pickerView.selectRow(row, inComponent: 0, animated: true)
            
            field.inputView = pickerView
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        let controller = UIApplication.shared.windows.first?.rootViewController
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func showToggleAlert(
        title: String,
        value: Bool,
        firstButtonTitle: String = Texts.yes.localized,
        firstButtonAction: @escaping (() -> Void) = { },
        secondButtonTitle: String = Texts.no.localized,
        secondButtonAction: @escaping (() -> Void) = { }
    ) {
        let actual = value ? Texts.yes.localized : Texts.no.localized
        let next = value ? Texts.no.localized : Texts.yes.localized
        
        let message = String.init(
            format: Texts.currentValueDisclaimer.localized,
            arguments: [actual, next]
        )
        
        let alert = UIAlertController(
            title: title.uppercased(),
            message: message,
            preferredStyle: .alert
        )
        
        let firstAction = UIAlertAction(
            title: firstButtonTitle,
            style: .default,
            handler: { _ in firstButtonAction() }
        )
        
        let secondAction = UIAlertAction(
            title: secondButtonTitle,
            style: .cancel,
            handler: { _ in secondButtonAction() }
        )
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        let controller = UIApplication.shared.windows.first?.rootViewController
        controller?.present(alert, animated: true, completion: nil)
    }
}

extension CustomAlerts: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.languages[row].name.uppercased()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.listAlertFieldValue.value = self.languages[row]
    }
}
