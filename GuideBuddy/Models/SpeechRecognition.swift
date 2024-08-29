//
//  SpeechRecognition.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 26/08/24.
//

import Foundation
import AVFoundation
import Speech
import SwiftUI

class SpeechRecognizer: ObservableObject {
    @Published var transcript: String = ""
    private var audioEngine = AVAudioEngine()
    private var speechRecognizer: SFSpeechRecognizer?
    private var request = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    
    init(locale: Locale = Locale(identifier: "en-US")) { // Default to English
        self.speechRecognizer = SFSpeechRecognizer(locale: locale)
    }

    func startTranscribing() {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else { return }
        
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Audio engine could not start. \(error.localizedDescription)")
        }
        
        recognitionTask = recognizer.recognitionTask(with: request) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.transcript = result.bestTranscription.formattedString
                }
            } else if let error = error {
                print("Recognition error: \(error.localizedDescription)")
            }
        }
    }
    
    func stopTranscribing() {
        recognitionTask?.finish()
        recognitionTask?.cancel()
        recognitionTask = nil
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    func resetTranscript() {
        self.transcript = ""
    }
    
    func setLocale(locale: Locale) {
        stopTranscribing()  // Stop current transcription
        self.speechRecognizer = SFSpeechRecognizer(locale: locale)
    }
}
