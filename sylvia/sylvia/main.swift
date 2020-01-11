//
//  main.swift
//  sylvia
//
//  Created by Dan Davison on 1/10/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation

let spectrogram = Spectrogram()
do {
    try spectrogram.createSpectrogram()
} catch {
    fatalError()
}
