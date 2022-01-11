//
//  CustomAlert.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 11/01/2022.
//

import SwiftUI

struct CustomAlert: View {
    
    @State var fieldText: String = ""
    let showInput: Bool
    let title: String
    let message: String
    var inputPlaceholder: String?
    var positiveButtonTitle: String?
    var negativeButtonTitle: String?
    var positiveButtonAction: ((Any?) -> Void)?
    var negativeButtonAction: (() -> Void)?
    
    var body: some View {
        ZStack {
            Spacer()
                .frame(
                    width: Constants.screenWidth,
                    height: Constants.screenHeight
                )
                .background(Color.gray)
                .opacity(0.2)
                .ignoresSafeArea(edges: .all)
            VStack {
                Text(self.title)
                    .bold()
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 8)
                Text(self.message)
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                
                if self.showInput {
                    Spacer().frame(height: 16)
                    HStack {
                        Spacer().frame(width: 16)
                        TextField(self.inputPlaceholder ?? "", text: self.$fieldText)
                            .multilineTextAlignment(.center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray)
                            )
                        Spacer().frame(width: 16)
                    }
                }
                
                Spacer().frame(height: 16)
                HStack {
                    if let positiveTitle = self.positiveButtonTitle {
                        Spacer()
                        Button(
                            positiveTitle,
                            action: {
                                self.positiveButtonAction?(
                                    self.showInput ? self.fieldText : nil
                                )
                            }
                        )
                        Spacer()
                    }
                    
                    if let negativeTitle = self.negativeButtonTitle {
                        Spacer()
                        Button(negativeTitle, action: { self.negativeButtonAction?() })
                        Spacer()
                    }
                }
            }
            .frame(width: Constants.screenWidth * 0.6)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(
            showInput: true,
            title: "Henlo",
            message: "How you doing friend?",
            positiveButtonTitle: "Aceptar",
            negativeButtonTitle: "Cancelar",
            positiveButtonAction: { print("positive tapped: ", $0 as Any) },
            negativeButtonAction: { print("negative tapped") }
        )
    }
}
