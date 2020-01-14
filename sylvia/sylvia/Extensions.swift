//
//  Extensions.swift
//  sylvia
//
//  Created by Dan Davison on 1/14/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
