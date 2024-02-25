//
//  AllProtocolsView.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct AllProtocolsView: View {
    @ObservedObject private var mainVM = MainViewModel.shared
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: TransferProtocol.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "shop == %@", argumentArray: [MainViewModel.shared.selectedShop ?? Shop()])
    ) var protocols: FetchedResults<TransferProtocol>
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                ForEach(protocols, id: \.id) { transferProtocol in
                    Text(transferProtocol.handingInSpecificationValue1 ?? "")
                }
                
//                ForEach(0...100, id:\.self) { number in
//                    Button {
//                        mainVM.presentedProtocol = "\(number)"
//                    } label: {
//                        HStack {
//                            Text("This is button number \(number)")
//                            
//                            Image(systemName: "chevron.right")
//                        }
//                        .padding(.horizontal)
//                    }
//                }
            }
            .padding(.bottom, 70)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}

struct AllProtocolsView_Previews: PreviewProvider {
    static var previews: some View {
        AllProtocolsView()
    }
}
