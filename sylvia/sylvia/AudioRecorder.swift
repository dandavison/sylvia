//
//  AudioRecorder.swift
//  sylvia-learn
//
//  Created by Dan Davison on 1/14/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {

    override init() {
        super.init()
        fetchRecordings()
    }

    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()

    var audioRecorder: AVAudioRecorder!

    var recordings = [Recording]()

    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }

    private var audioFilename = URL(fileURLWithPath: "")

    func makeSpectrogramFilename() -> URL {
        return URL(fileURLWithPath: "\(self.audioFilename.path).png")
    }

    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filenameBase = Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")
        self.audioFilename = documentPath.appendingPathComponent("\(filenameBase).wav")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: self.audioFilename, settings: settings)
            audioRecorder.record()
            recording = true
        } catch {
            print("Could not start recording")
        }
    }

    func stopRecording() {
        audioRecorder.stop()
        recording = false
        let spectrogram = Spectrogram()
        let image = spectrogram.createSpectrogram(self.audioFilename, chunkSize: 1024)!
        saveImage(image: image.cgImage, url: self.makeSpectrogramFilename())
        fetchRecordings()
    }

    func fetchRecordings() {
        recordings.removeAll()

        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for filename in directoryContents {
            if filename.pathExtension == "wav" {
                let recording = Recording(audioFilename: filename,
                                          spectrogramFilename: self.makeSpectrogramFilename(),
                                          createdAt: getCreationDate(for: filename))
                recordings.append(recording)
            }
        }
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        objectWillChange.send(self)
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
