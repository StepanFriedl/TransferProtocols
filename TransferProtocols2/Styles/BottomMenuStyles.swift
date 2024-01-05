//
//  BottomMenuStyles.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct BottomMenuColor: ViewModifier {
    let condition: Bool
    
    func body(content: Content) -> some View {
        content.foregroundColor(condition ? .blue : .gray)
    }
}

extension View {
    func menuButtonColor(_ condition: Bool) -> some View {
        modifier(BottomMenuColor(condition: condition))
    }
}
