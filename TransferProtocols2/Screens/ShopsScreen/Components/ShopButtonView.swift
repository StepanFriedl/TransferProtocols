//
//  ShopButtonView.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 19.02.2024.
//

import SwiftUI

struct ShopButtonView: View {
    @ObservedObject private var mainVM = MainViewModel.shared
    
    let shop: Shop
    
    var body: some View {
        Button {
            mainVM.selectedShop = shop
            mainVM.mainViewScreen = .protocols
        } label: {
            ZStack {
                Text(shop.companyName ?? "Unknown name")
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
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

//#Preview {
//    ShopButtonView(
//        shop: Shop()
//    )
//}
