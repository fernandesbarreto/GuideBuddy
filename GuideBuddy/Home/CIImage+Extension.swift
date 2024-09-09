////
////  CIImage+Extension.swift
////  GuideBuddy
////
////  Created by Pedro Henrique Nunes da Silveira Bezerra on 30/08/24.
////
//
//import Foundation
//import CoreImage
//import AVFoundation
//
//extension CIImage {
//    
//    var cgImage: CGImage? {
//        let ciContext = CIContext()
//        
//        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else {
//            return nil
//        }
//        
//        return cgImage
//    }
//    
//}
//
//extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
//    
//    func captureOutput(_ output: AVCaptureOutput,
//                       didOutput sampleBuffer: CMSampleBuffer,
//                       from connection: AVCaptureConnection) {
//        guard let currentFrame = sampleBuffer.cgImage else { return }
//        addToPreviewStream?(currentFrame)
//    }
//    
//}
