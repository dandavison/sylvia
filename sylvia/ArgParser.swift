//
//  ArgParser.swift
//  sylvia
//
//  Created by Dan Davison on 1/11/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation

enum ArgType {
    case InputFile
    case OutputFile
    case ChunkSize
}

func parseArgs() throws -> [ArgType: String] {
    var args: [ArgType: String] = [:]
    var i = 1
    while i < CommandLine.argc {
        let key = CommandLine.arguments[i]
        let val = CommandLine.arguments[i + 1]
        i += 2
        switch key {
            case "-i": args[.InputFile] = val
            case "-o": args[.OutputFile] = val
            case "-s": args[.ChunkSize] = val
            case _: fatalError("Unexpected argument")
        }
    }
    return args
}
