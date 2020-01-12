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
    func loadAudioData(_ inputFile: String) -> [Float]? {
        let url = URL(fileURLWithPath: inputFile)
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

    func createSpectrogram() throws {
        let args: [ArgType: String]
        do {
            try args = parseArgs()
        } catch {
            fatalError()
        }
        if let audio = loadAudioData(args[.InputFile]!) {
            var fftValues = [[Float]]()
            for chunk in audio.chunks(1024) {
                fftValues.append(Array(fft(chunk).real[0..<512]))
            }
            print("Computed FFT: \(fftValues.count) x \(fftValues[0].count)")

            if let image = drawMagnitudes(magnitudes: fftValues) {
                print("Created output PNG")
                saveImage(image: image.cgImage, url: URL(fileURLWithPath: args[.OutputFile]!))
            }
        }
    }
}
