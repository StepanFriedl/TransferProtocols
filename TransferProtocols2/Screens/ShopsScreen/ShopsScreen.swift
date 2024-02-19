//
//  ShopsScreen.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 19.02.2024.
//

import SwiftUI

struct ShopsScreen: View {
    @State private var addShopShown: Bool = false
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVGrid(
                columns: [
                    GridItem( .adaptive(minimum: 150, maximum: 150), spacing: 16 )
                ],
                spacing: 16) {
                    ForEach(0..<6, id: \.self) { number in
                        ShopButtonView()
                    }
                    AddNewShopButtonView(
                        action: {
                            MainViewModel.shared.mainViewScreen = .addShop
                        }
                    )
                }
                .padding(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ShopsScreen()
}
