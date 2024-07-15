//
//  PortionResultViewDecimalPadModifier.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 15/07/24.
//

import Foundation
import Combine
import SwiftUI

struct PortionResultViewDecimalPadModifier: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.decimalPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "0123456789"
                let decimalSeparator: String = Locale.current.decimalSeparator ?? ","
                if newValue.components(separatedBy: decimalSeparator).count-1 > 1 {
                    let filtered = newValue
                    self.text = String(filtered.dropLast())
                } else {
                    let filtered = newValue.filter{numbers.contains($0)}
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
            }
    }
}

extension View {
    func numbersOnly (_ text: Binding<String>) -> some View {
        self.modifier(PortionResultViewDecimalPadModifier(text: text))
    }
}
