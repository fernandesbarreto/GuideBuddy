////
////  CameraButton.swift
////  GuideBuddy
////
////  Created by Pedro Henrique Nunes da Silveira Bezerra on 30/08/24.
////
//
//import SwiftUI
//import UIKit
//import SwiftData
//
//
//struct ImagePicker: UIViewControllerRepresentable {
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//    
//    
//    @Binding var selectedImage: UIImage?
//    @Environment(\.modelContext) private var context
//    @Environment(\.presentationMode) private var presentationMode
//    var sourceType: UIImagePickerController.SourceType = .camera
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = context.coordinator
//        imagePicker.sourceType = sourceType
//        return imagePicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//    }
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//        
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.selectedImage = image
//                if let modelContext = parent.context as? ModelContext {
//                    modelContext.insert(ProfilePhoto(profilePhoto: image))
//                }
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
