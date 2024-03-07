//
//  SignatureView.swift
//  TransferProtocols2
//
//  Created by Štěpán Friedl on 03.03.2024.
//

import SwiftUI

struct SignatureView: View {
    @State var closeViewAction: (UIImage) -> Void
    
    @State private var drawings: [[CGPoint]] = []
    @State private var currentDrawing: [CGPoint] = []
    
    var body: some View {
        VStack {
            HStack {
                // MARK: - Erase the signature view button
                Button {
                    drawings = []
                    currentDrawing = []
                } label: {
                    Image(systemName: "eraser.line.dashed")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                }
                
                Spacer()
                
                // MARK: - Close view button
                Button {
                    if let uiImage = self.exportDrawing() {
                        print(uiImage)
                        closeViewAction(uiImage)
                    }
                } label: {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                }
            }
            .padding(.horizontal, 32)
            
            VStack {
                ZStack {
                    Canvas { context, _ in
                        for drawing in drawings {
                            let _ = Path { path in
                                if !drawing.isEmpty {
                                    path.move(to: drawing[0])
                                    for point in drawing.dropFirst() {
                                        path.addLine(to: point)
                                    }
                                    context.stroke(path, with: .color(.black), lineWidth: 5.0)
                                }
                            }
                        }
                        let _ = Path { path in
                            if !currentDrawing.isEmpty {
                                path.move(to: currentDrawing[0])
                                for point in currentDrawing.dropFirst() {
                                    path.addLine(to: point)
                                }
                                context.stroke(path, with: .color(.black), lineWidth: 5.0)
                            }
                        }
                    }
                    .frame(width: 600, height: 250)
                    .border(Color.red)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                updateDrawing(point: value.location)
                            }
                            .onEnded { _ in
                                finishDrawing()
                            }
                    )
                }
                
                Divider()
                    .background(.black)
                    .padding(.horizontal, 64)
                
                Text("signature")
                    .padding(.bottom, 16)
                    .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .background(.white)
        .frame(width: UIScreen.main.bounds.size.height, height: UIScreen.main.bounds.size.width)
        .rotationEffect(.degrees(-90))
    }
    
    func updateDrawing(point: CGPoint) {
        currentDrawing.append(point)
    }
    
    func finishDrawing() {
        drawings.append(currentDrawing)
        currentDrawing.removeAll()
    }
    
    func exportDrawing() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 600, height: 250))
        let image = renderer.image { context in
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(2)
            
            for drawing in drawings {
                for (index, point) in drawing.enumerated() {
                    if index == 0 {
                        context.cgContext.move(to: CGPoint(x: point.x, y: point.y))
                    } else {
                        context.cgContext.addLine(to: CGPoint(x: point.x, y: point.y))
                    }
                }
                context.cgContext.strokePath()
            }
        }
        return image
    }
}


struct Drawing: Identifiable {
    var id = UUID()
    var path = Path()
    var color = Color.black
    var lineWidth: CGFloat = 5.0
}

#Preview {
    SignatureView(
        closeViewAction: { _ in }
    )
}
