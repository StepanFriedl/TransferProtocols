//
//  NewProtocolFormStyles.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 06.01.2024.
//

import SwiftUI

struct NewProtocolTextInput: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.custom(FontsManager.Quicksand.regular, size: 18))
            .frame(maxWidth: .infinity, minHeight: 25)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.ultraThinMaterial)
            )
            .scrollContentBackground(.hidden)
    }
}

struct AddPhotoButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.custom(FontsManager.Quicksand.bold, size: 18))
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.ultraThickMaterial)
            )
            .foregroundColor(.black)
    }
    
}

struct DateTextView: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(minHeight: 25)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.ultraThinMaterial)
            )
    }
    
}

struct SaveButton: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
            .frame(width: 200, height: 75)
            .font(.custom(FontsManager.Quicksand.bold, size: 25))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.black.opacity(0.5))
            )
            .foregroundColor(.white)
            .shadow(color: .black, radius: 12)
    }
    
}

extension View {
    func newProtocolTextInput() -> some View {
        modifier(NewProtocolTextInput())
    }
    
    func addPhotoButton() -> some View {
        modifier(AddPhotoButton())
    }
    
    func dateTextView() -> some View {
        modifier(DateTextView())
    }
    
    func saveButton() -> some View {
        modifier(SaveButton())
    }
}
