//
//  CreateUploadImageSection.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 14.11.24.
//
import SwiftUI

public struct CreateUploadImageSection: View {
    var title: String
    let cameraSources: [CameraOptions] = [
        CameraOptions(itemName: "Camera", icon: "", isComingSoon: false),
        CameraOptions(itemName: "Photo Gallery", icon: "", isComingSoon: false)
    ]
    
    @State private var image: UIImage?
    @State private var showImagePicker = false
    @State private var selectImageSource = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var images: [UIImage] = [] // Updated to UIImage array
        
    public init(title: String, image: UIImage? = nil, showImagePicker: Bool = false, selectImageSource: Bool = false, images: [UIImage]) {
        self.title = title
        self.image = image
        self.showImagePicker = showImagePicker
        self.selectImageSource = selectImageSource
        self.images = images
    }
    
    public var body: some View {
        
        VStack(alignment: .leading) {
            if title != "" {
                Text(title)
                    .foregroundColor(Theme.whiteColor)
                    .font(Fonts.Bold.returnFont(sizeType: .title))
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(images.indices, id: \.self) { index in // Use indices to loop through `images`
                        ZStack {
                            Image(uiImage: images[index])
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        images.remove(at: index) // Remove image on button tap
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                            .frame(width: 20, height: 20)
                                    }
                                }
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 1)
                    }
                    
                    // Button to add a new image
                    Button {
                        selectImageSource = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(Theme.grey)
                                .frame(width: 70, height: 75)
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Theme.whiteColor)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding()
        
        // Action sheet for selecting the image source
        .sheet(isPresented: $selectImageSource) {
            ZStack {
                Color.black
                VStack {
                    Button(action: {
                        sourceType = .camera
                        selectImageSource.toggle()
                        showImagePicker = true
                    }) {
                        Text("Take photo")
                            .foregroundColor(.white)
                            .font(Fonts.Bold.returnFont(sizeType: .title))
                            .padding()
                    }
                    Button(action: {
                        sourceType = .photoLibrary
                        selectImageSource.toggle()
                        showImagePicker = true
                    }) {
                        Text("Select from photo library")
                            .foregroundColor(.white)
                            .font(Fonts.Bold.returnFont(sizeType: .title))
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .presentationDetents([.fraction(0.2)])
            }
            .background(.black)
        }
        
        // Image Picker for selecting or capturing an image
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(image: $image, showImagePicker: $showImagePicker, sourceType: $sourceType)
                .presentationDetents([.fraction(1)])
        }
        
        // When a new image is selected, add it to `images`
        .onChange(of: image) { newImage in
            if let newImage = newImage {
                images.append(newImage)
            }
        }
    }
}

public struct UploadSingleImage: View {
    var title: String
    let cameraSources: [CameraOptions] = [
        CameraOptions(itemName: "Camera", icon: "", isComingSoon: false),
        CameraOptions(itemName: "Photo Gallery", icon: "", isComingSoon: false)
    ]
    
    
    @State private var showImagePicker = false
    @State private var selectImageSource = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var aImage: UIImage?
    
    public init(title: String, showImagePicker: Bool = false, selectImageSource: Bool = false) {
        self.title = title
        self.showImagePicker = showImagePicker
        self.selectImageSource = selectImageSource
        self.aImage = aImage
    }
    
    public var body: some View {
        
        HStack {
            Text(title)
               .foregroundColor(Theme.whiteColor)
               .font(Fonts.Bold.returnFont(sizeType: .title))
            
            Spacer()
              Button {
                    selectImageSource = true
                } label: {
                    if let aImage  {
                        Image(uiImage: aImage)
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(.gray)
                                .frame(width: 70, height: 75)
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Theme.whiteColor)
                        }
                    }
                }
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
        }
        .sheet(isPresented: $selectImageSource) {
                ZStack {
                    Color.black
                    VStack {
                        Button(action: {
                            sourceType = .camera
                            selectImageSource.toggle()
                            showImagePicker = true
                        }) {
                            Text("Take photo")
                                .foregroundColor(.white)
                                .font(Fonts.Bold.returnFont(sizeType: .title))
                                .padding()
                        }
                        Button(action: {
                            sourceType = .photoLibrary
                            selectImageSource.toggle()
                            showImagePicker = true
                        }) {
                            Text("Select from photo library")
                                .foregroundColor(.white)
                                .font(Fonts.Bold.returnFont(sizeType: .title))
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .presentationDetents([.fraction(0.2)])
                }
                .background(.black)
            }
        .sheet(isPresented: $showImagePicker) {
                ImagePickerView(image: $aImage, showImagePicker: $showImagePicker, sourceType: $sourceType)
                    .presentationDetents([.fraction(1)])
            }
        .onChange(of: aImage) { newImage in
                if let newImage = newImage {
                    aImage = newImage
                }
            }
    }
}
