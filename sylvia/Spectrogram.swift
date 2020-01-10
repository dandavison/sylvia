//
//  Spectrogram.swift
//  sylvia
//
//  Created by Dan Davison on 1/10/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation

class Spectrogram {
    let consoleIO = ConsoleIO()

    func loadAudioData() {
        let url = URL(fileURLWithPath: "/Users/dan/src/3p/iOS-Spectrogram/UIImage_SpectrogramTests/toujours.wav")
        if let audio = DataLoader.loadAudioSamplesArrayOf(Float.self, atUrl:url) {
            print("Loaded audio data: \(audio.count)")
        }
    }

    func staticMode() {
        consoleIO.printUsage()
    }
}
