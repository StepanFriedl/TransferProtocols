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
        sortDescriptors: [
            NSSortDescriptor(keyPath: \TransferProtocol.created, ascending: true)
        ],
        predicate: NSPredicate(format: "shop == %@", argumentArray: [MainViewModel.shared.selectedShop ?? Shop()])
    ) var protocols: FetchedResults<TransferProtocol>
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                if protocols.count > 0 {
                    ForEach(protocols, id: \.id) { transferProtocol in
                        Button {
                            mainVM.selectedProtocol = transferProtocol
                            mainVM.shopScreensPage = .protocolDetails
                        } label: {
                            HStack {
                                Text(transferProtocol.customerFullName ?? "")
                                    .font(.custom(FontsManager.Quicksand.bold, size: 16))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .foregroundStyle(.black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.ultraThinMaterial)
                            )
                        }
                    }
                } else {
                    Text("No protocols.")
                        .font(.custom(FontsManager.Quicksand.semiBold, size: 20))
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 32)
            .padding(.bottom, 70)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AllProtocolsView_Previews: PreviewProvider {
    static var previews: some View {
        AllProtocolsView()
    }
}
