//
//  ImageUtils.swift
//  sylvia
//
//  Created by Dan Davison on 1/10/20.
//  Copyright © 2020 Dan Davison. All rights reserved.

import CoreGraphics
import Foundation
import ImageIO

#if !os(macOS)
import MobileCoreServices
#else
import CoreServices
#endif


// https://stackoverflow.com/a/7668343/583763
func saveImage(image: CGImage, url: URL) -> Bool {
    let destination = CGImageDestinationCreateWithURL(url as CFURL, kUTTypePNG, 1, nil)!
    CGImageDestinationAddImage(destination, image, nil)
    CGImageDestinationFinalize(destination)
    return true
}
