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
    func loadAudioData(_ inputFile: URL) -> [Float]? {
        if let audio = DataLoader.loadAudioSamplesArrayOf(Float.self, atUrl: inputFile) {
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

    func createSpectrogram(_ inputFile: URL, chunkSize: Int) -> Image<RGBA<Float>>? {
        let chunkStep = 100

        if let audio = loadAudioData(inputFile) {
            var fftValues = [[Float]]()

            for chunk in audio.slidingChunks(chunkSize, chunkStep:chunkStep) {
                if chunk.count == chunkSize {
                    let fftChunkValues = fft(applyWindow(chunk)).real.map {
                        log(abs($0) + 1.0)
                    }
                    fftValues.append(Array(fftChunkValues[0..<(chunkSize >> 1)]))
                }
            }
            print("Computed FFT: \(fftValues.count) x \(fftValues.first!.count)")
            return drawMagnitudes(magnitudes: fftValues)
        } else {
            return nil
        }
    }
}
