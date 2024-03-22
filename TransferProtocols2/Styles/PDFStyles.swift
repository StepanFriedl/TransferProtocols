//
//  PDFStyles.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 22.03.2024.
//

import SwiftUI

struct PDFBigTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontsManager.Quicksand.semiBold, size: 60))
    }
}

struct PDFTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontsManager.Quicksand.medium, size: 40))
            .foregroundStyle(.black)
    }
}

struct PDFText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontsManager.Quicksand.regular, size: 30))
    }
}

extension Text {
    func pdfBigTitle() -> some View {
        modifier(PDFBigTitle())
    }
    
    func pdfTitle() -> some View {
        modifier(PDFTitle())
    }
    
    func pdfText() -> some View {
        modifier(PDFText())
    }
}
