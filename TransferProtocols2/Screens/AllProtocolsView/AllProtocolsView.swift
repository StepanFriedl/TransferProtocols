//
//  AllProtocolsView.swift
//  Transfer Protocols
//
//  Created by Štěpán Friedl on 05.01.2024.
//

import SwiftUI

struct AllProtocolsView: View {
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                ForEach(0...100, id:\.self) { number in
                    HStack {
                        Text("This is button number \(number)")
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal)
                }
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
