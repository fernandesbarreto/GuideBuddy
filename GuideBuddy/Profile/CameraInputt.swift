//
//  CameraInputt.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 30/08/24.
//

import SwiftUI

struct CameraInputView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(10)
                    .padding()
            } else {
                Text("No Image Selected")
                    .font(.headline)
                    .padding()
            }

            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Open Camera")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
            }
        }
    }
}
