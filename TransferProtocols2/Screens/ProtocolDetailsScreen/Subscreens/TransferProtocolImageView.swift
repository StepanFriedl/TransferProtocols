//
//  TransferProtocolImageView.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 21.03.2024.
//

import SwiftUI

struct TransferProtocolImageView: View {
    let imageOne: Data?
    let imageTwo: Data?
    
    let imagesType: ImageType
    let index: Int
    
    var body: some View {
        VStack {
            if index == 0 {
                switch imagesType {
                case .handingIn:
                    Text("Handing in images:")
                        .pdfBigTitle()
                case .handingOut:
                    Text("Handing out images:")
                        .pdfBigTitle()
                }
            }
            VStack {
                if let imageOne = imageOne,
                   let uiImage = UIImage(data: imageOne) {
                    Text("Image \(index + 1):")
                        .pdfTitle()
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                if let imageTwo = imageTwo,
                   let uiImage = UIImage(data: imageTwo) {
                    Text("Image \(index + 2):")
                        .pdfTitle()
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(160)
    }
}

enum ImageType {
    case handingIn
    case handingOut
}

#Preview {
    TransferProtocolImageView(
        imageOne: nil,
        imageTwo: nil,
        imagesType: .handingIn,
        index: 0
    )
}
