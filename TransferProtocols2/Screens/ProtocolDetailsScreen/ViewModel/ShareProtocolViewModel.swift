// ShareProtocolViewModel.swift

import SwiftUI
import Darwin

class ShareProtocolViewModel {
    
    let protocolPictures: FetchedResults<HandingInPicture>
    
    init(protocolPictures: FetchedResults<HandingInPicture>) {
        self.protocolPictures = protocolPictures
    }
    
    @MainActor func shareThePDFView() {
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("\(UUID().uuidString).pdf") // Fixed appendingPathComponent
        
        let transferProtocolRenderer = ImageRenderer(content: TransferProtocolView(protocolPictures: protocolPictures).frame(width: 2480, height: 3508, alignment: .center))
        
        // Assuming transferProtocolImages is an array of images to be rendered
        let transferProtocolImages = [UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "image3")]
        
        if let consumer = CGDataConsumer(url: url as CFURL),
           let context = CGContext(consumer: consumer, mediaBox: nil, nil) {
            
            transferProtocolRenderer.render { size, renderer in
                var mediaBox = CGRect(origin: .zero, size: size)
                
                context.beginPage(mediaBox: &mediaBox)
                renderer(context)
                context.endPDFPage()
            }
            
            for index in 0..<Int(ceil(Double(protocolPictures.count) / 2)) {
                let imageOne = protocolPictures[index * 2].pictureData
                var imageTwo: Data? = nil
                if ((index * 2) + 1) < protocolPictures.count {
                    imageTwo = protocolPictures[(index * 2) + 1].pictureData
                }
                
                let transferProtocolImageRenderer = ImageRenderer(content: TransferProtocolImageView(
                    imageOne: imageOne,
                    imageTwo: imageTwo,
                    imagesType: .handingIn,
                    index: index
                ).frame(width: 2480, height: 3508, alignment: .center))
                transferProtocolImageRenderer.render { size, renderer in
                    var mediaBox = CGRect(origin: .zero, size: size)
                    
                    context.beginPage(mediaBox: &mediaBox)
                    renderer(context)
                    context.endPDFPage()
                }
            }
            
//            for image in transferProtocolImages {
//                let transferProtocolImageRenderer = ImageRenderer(content: TransferProtocolImageView(image: image ?? UIImage()).frame(width: 2480, height: 3508, alignment: .center))
//                transferProtocolImageRenderer.render { size, renderer in
//                    var mediaBox = CGRect(origin: .zero, size: size)
//                    
//                    context.beginPage(mediaBox: &mediaBox)
//                    renderer(context)
//                    context.endPDFPage()
//                }
//            }
            
            context.closePDF() // Moved closePDF outside the loop
            
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
                self.removeFile(at: url)
            }
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                if let popoverController = activityViewController.popoverPresentationController {
                    popoverController.sourceView = window
                    popoverController.sourceRect = CGRect(x: window.bounds.width / 2, y: window.bounds.height / 2, width: 0, height: 0)
                    popoverController.permittedArrowDirections = []
                }
                window.rootViewController?.present(activityViewController, animated: true, completion: nil)
            }

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                if let popoverController = activityViewController.popoverPresentationController {
                    popoverController.sourceView = window
                    popoverController.sourceRect = CGRect(x: window.bounds.width / 2, y: window.bounds.height / 2, width: 0, height: 0)
                    popoverController.permittedArrowDirections = []
                }
                window.rootViewController?.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    func removeFile(at url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
            print("PDF file removed from: \(url)")
        } catch {
            print("Error removing PDF file: \(error)")
        }
    }
}
