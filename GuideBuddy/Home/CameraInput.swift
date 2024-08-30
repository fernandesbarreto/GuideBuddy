////
////  CameraInput.swift
////  GuideBuddy
////
////  Created by Pedro Henrique Nunes da Silveira Bezerra on 30/08/24.
////
//
//import Foundation
//import AVFoundation
//import CoreImage
//
//class CameraManager: NSObject {
//    // 1.
//    private let captureSession = AVCaptureSession()
//    // 2.
//    private var deviceInput: AVCaptureDeviceInput?
//    // 3.
//    private var videoOutput: AVCaptureVideoDataOutput?
//    // 4.
//    private let systemPreferredCamera = AVCaptureDevice.default(for: .video)
//    // 5.
//    private var sessionQueue = DispatchQueue(label: "video.preview.session")
//    
//    private var isAuthorized: Bool {
//         get async {
//             let status = AVCaptureDevice.authorizationStatus(for: .video)
//             
//             // Determine if the user previously authorized camera access.
//             var isAuthorized = status == .authorized
//             
//             // If the system hasn't determined the user's authorization status,
//             // explicitly prompt them for approval.
//             if status == .notDetermined {
//                 isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
//             }
//             
//             return isAuthorized
//         }
//     }
//    
//    private var addToPreviewStream: ((CGImage) -> Void)?
//       
//       lazy var previewStream: AsyncStream<CGImage> = {
//           AsyncStream { continuation in
//               addToPreviewStream = { cgImage in
//                   continuation.yield(cgImage)
//               }
//           }
//       }()
//    
//    // 1.
//      override init() {
//          super.init()
//          
//          Task {
//              await configureSession()
//              await startSession()
//          }
//      }
//      
//      // 2.
//      private func configureSession() async {
//          
//      }
//      
//      // 3.
//      private func startSession() async {
//             
//      }
//    
//    var cgImage: CGImage? {
//        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self as! CMSampleBuffer)
//          
//          guard let imagePixelBuffer = pixelBuffer else {
//              return nil
//          }
//          
//          return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
//      }
//}
