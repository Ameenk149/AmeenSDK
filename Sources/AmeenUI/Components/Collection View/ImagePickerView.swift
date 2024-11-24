//
//  ImagePickerView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 14.11.24.
//
import SwiftUI

@available(iOS 16.0, *)
public struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var showImagePicker: Bool
    @Binding var sourceType: UIImagePickerController.SourceType
    
    public func makeCoordinator() -> CoordinatorForImage {
        Coordinator(image: $image, showImagePicker: $showImagePicker)
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update needed
    }
    
    public class CoordinatorForImage: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: UIImage?
        @Binding var showImagePicker: Bool
        
        public init(image: Binding<UIImage?>, showImagePicker: Binding<Bool>) {
            _image = image
            _showImagePicker = showImagePicker
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                image = selectedImage
            }
            showImagePicker = false
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            showImagePicker = false
        }
    }
}
