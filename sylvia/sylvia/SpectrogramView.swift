//
//  SpectrogramView.swift
//  sylvia
//
//  Created by Dan Davison on 1/14/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import SwiftUI

struct SpectrogramView: View {

    var spectrogramFilename: URL

    var body: some View {
        print("SpectrogramView: displaying image: \(self.spectrogramFilename)")
        return Image(uiImage: UIImage(contentsOfFile: self.spectrogramFilename.path)!)
    }
}
