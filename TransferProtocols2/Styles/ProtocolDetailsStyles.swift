//
//  ProtocolDetailsStyles.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 27.02.2024.
//

import SwiftUI

struct ProtocolDetailsBigTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontsManager.Quicksand.bold, size: 20))
            .foregroundStyle(.black)
            .padding(.bottom, 8)
    }
}

struct ProtocolDetailsTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontsManager.Quicksand.semiBold, size: 18))
            .foregroundStyle(.black)
    }
}

struct ProtocolDetailsText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontsManager.Quicksand.regular, size: 14))
            .padding(.bottom, 8)
            .foregroundStyle(.black)
    }
}

extension Text {
    func protocolDetailsBigTitle() -> some View {
        modifier(ProtocolDetailsBigTitle())
    }
    
    func protocolDetailsTitle() -> some View {
        modifier(ProtocolDetailsTitle())
    }
    
    func protocolDetailsText() -> some View {
        modifier(ProtocolDetailsText())
    }
}
