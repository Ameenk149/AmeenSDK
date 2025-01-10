//
//  QRCode.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 10.01.25.
//
import SwiftUI
import CoreImage

public struct QRCodeSheet: View {
    let qrString: String
    let context = CIContext()
    
    var qrImage: UIImage? {
        generateQRCode(from: qrString)
    }
    public init(qrString: String) {
        self.qrString = qrString
    }
    public var body: some View {
        VStack {
            if let qrImage = qrImage {
                Image(uiImage: qrImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Text("Failed to generate QR Code")
            }
            
            Text(qrString)
                .padding()
                .font(.footnote)
        }
        .padding()
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        // Create QR code filter
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = string.data(using: .utf8)
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel") // Error correction level
        
        // Generate the CIImage
        guard let outputImage = filter.outputImage else { return nil }
        
        // Scale the QR code image
        let transform = CGAffineTransform(scaleX: 10, y: 10) // Scale up the QR code
        let scaledImage = outputImage.transformed(by: transform)
        
        // Convert to UIImage
        if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}
