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
        List {
            if protocols.count > 0 {
                ForEach(protocols, id: \.id) { transferProtocol in
                    HStack {
                        Text(transferProtocol.customerFullName ?? "")
                            .font(.custom(FontsManager.Quicksand.bold, size: 16))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                        
                    }
                    .foregroundStyle(.black)
                    .onTapGesture {
                        mainVM.selectedProtocol = transferProtocol
                        mainVM.shopScreensPage = .protocolDetails
                    }
                }
                .onDelete(perform: delete)
                .listRowBackground(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                )
                
            } else {
                Text("No protocols.")
                    .font(.custom(FontsManager.Quicksand.semiBold, size: 20))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollContentBackground(.hidden)
        .listStyle(.automatic)
        .listRowSpacing(8)
        .listRowSeparator(.hidden)
    }
    
    func delete(at offsets: IndexSet) {
        // TODO: - Add the delete logic
        for index in offsets {
            let shop = protocols[index]
            moc.delete(shop)
        }
        do {
            try moc.save()
        } catch {
            print("Error deleting the protocol: \(error.localizedDescription)")
            // TODO: - Add an error handling
        }
    }
}

struct AllProtocolsView_Previews: PreviewProvider {
    static var previews: some View {
        AllProtocolsView()
    }
}
