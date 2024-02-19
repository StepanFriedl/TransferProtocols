//
//  AddNewShopButtonView.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 19.02.2024.
//

import SwiftUI

struct AddNewShopButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
            .frame(width: 150, height: 150)
            .background(
                RoundedRectangle(cornerRadius: 32)
                    .fill(.white)
                    .shadow(color: .black, radius: 8, x: 8, y: 8)
            )
        }
    }
}

#Preview {
    AddNewShopButtonView(
        action: {}
    )
}
