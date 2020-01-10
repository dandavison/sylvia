//
//  ConsoleIO.swift
//  sylvia
//
//  Created by Dan Davison on 1/10/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation

enum OutputStream {
    case stdout
    case stderr
}


class ConsoleIO {
    
    func writeStream(_ text: String, stream: OutputStream = .stdout) {
        switch stream {
        case .stdout:
            print("\(text)")
        case .stderr:
            fputs("Error: \(text)\n", stderr)
        }
    }
    
    func printUsage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeStream("usage:")
        writeStream("\(executableName) -a string1 string2")
        writeStream("or")
        writeStream("\(executableName) -p string")
        writeStream("or")
        writeStream("\(executableName) -h to show usage information")
        writeStream("Type \(executableName) without an option to enter interactive mode.")
    }
}
