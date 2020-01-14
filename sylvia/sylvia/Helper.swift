//
//  Helper.swift
//  sylvia
//
//  Created by Dan Davison on 1/14/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation

func getCreationDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
        let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}
