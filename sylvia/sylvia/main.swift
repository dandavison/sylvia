//
//  main.swift
//  sylvia
//
//  Created by Dan Davison on 1/10/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation

let args: [ArgType: String]
do {
    try args = parseArgs()
} catch {
    fatalError()
}

let spectrogram = Spectrogram()
let image = spectrogram.createSpectrogram(URL(fileURLWithPath: args[.InputFile]!), chunkSize: Int(args[.ChunkSize]!)!)!
saveImage(image: image.cgImage, url: URL(fileURLWithPath: args[.OutputFile]!))
