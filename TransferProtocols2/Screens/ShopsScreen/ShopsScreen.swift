//
//  ShopsScreen.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 19.02.2024.
//

import SwiftUI
import CoreData

struct ShopsScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var shops: FetchedResults<Shop>
    
    @State private var addShopShown: Bool = false
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVGrid(
                columns: [
                    GridItem( .adaptive(minimum: 150, maximum: 150), spacing: 16 )
                ],
                spacing: 16) {
                    ForEach(shops, id: \.id) { shop in
                        ShopButtonView(shop: shop)
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
