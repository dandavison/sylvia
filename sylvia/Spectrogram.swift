//
//  Spectrogram.swift
//  sylvia
//
//  Created by Dan Davison on 1/10/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation
import SwiftImage

class Spectrogram {
    func loadAudioData() -> [Float]? {
        let url = URL(fileURLWithPath: "/Users/dan/src/3p/iOS-Spectrogram/UIImage_SpectrogramTests/toujours.wav")
        if let audio = DataLoader.loadAudioSamplesArrayOf(Float.self, atUrl:url) {
            print("Loaded audio data: \(audio.count)")
            return audio
        }
        return nil
    }

    // Magnitudes are normalized [0;1]
    func drawMagnitudes(magnitudes:[[Float]], width:Int? = nil, height:Int? = nil) -> Image<RGBA<Float>>? {

        let timeWidth = magnitudes.count
        let frequencyHeight = magnitudes.first!.count

        let pixels = magnitudes.map{ $0.map{ RGBA<Float>(red: 1-$0, green: 1-$0, blue: 1-$0, alpha: 1.0) } }

        let flattenedPixels = pixels.flatMap{ $0 }

        var image = Image<RGBA<Float>>(width: frequencyHeight, height:timeWidth , pixels: flattenedPixels)
        image = image.rotated(byDegrees: -90)

        if let w = width,
            let h = height {
            image = image.resizedTo(width: w, height: h)
        }

        return image
    }

    func createSpectrogram() {
        if let audio = loadAudioData() {
            var fftValues = [[Float]]()
            for chunk in audio.chunks(1024) {
                fftValues.append(fft(chunk).real)
            }
            print("Computed FFT: \(fftValues.count) x \(fftValues[0].count)")

            if let image = drawMagnitudes(magnitudes: fftValues) {
                saveImage(image: image.cgImage, url: URL(fileURLWithPath: "/tmp/sylvia-spectrogram.png"))
                print("Created output PNG")
            }
        }
    }
}
