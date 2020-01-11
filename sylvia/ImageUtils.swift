//
//  ImageUtils.swift
//  sylvia
//
//  Created by Dan Davison on 1/10/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//
// https://github.com/t-ae/EasyImagySaveExperiment/blob/29874751050d16e92ee7d2898ff218a5f169902a/EasyImagySaveExperiment/ViewController.swift

import Cocoa
import Foundation

func saveImage(image: NSImage, url: URL) -> Bool {
    let data = image.tiffRepresentation!
    let b = NSBitmapImageRep.imageReps(with: data).first! as! NSBitmapImageRep
    let pngData = b.representation(using: NSBitmapImageRep.FileType.png, properties: [:])!

    do {
        try pngData.write(to: url, options: Data.WritingOptions.atomic)
        print("save: \(url)")
        return true
    } catch(let e) {
        print("failed")
        return false
    }
}

func saveImage(image: CGImage, url: URL) -> Bool {
    let rep = NSBitmapImageRep(cgImage: image)
    let pngData = rep.representation(using: NSBitmapImageRep.FileType.png, properties: [:])!

    do {
        try pngData.write(to: url, options: Data.WritingOptions.atomic)
        print("save: \(url)")
        return true
    } catch(let e) {
        print("failed")
        return false
    }
}
