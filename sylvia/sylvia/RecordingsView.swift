//
//  RecordingsList.swift
//  sylvia
//
//  Created by Dan Davison on 1/14/20.
//  Copyright © 2020 Dan Davison. All rights reserved.
//

import Foundation
import SwiftUI

struct RecordingRow: View {

    var audioFilename: URL
    var spectrogramFilename: URL

    @ObservedObject var audioPlayer = AudioPlayer()
    @State private var isPlaying = false

    var body: some View {
        HStack {
            Text("\(audioFilename.lastPathComponent)")
            Spacer()
            if audioPlayer.isPlaying == false {
                Button(action: {
                    self.audioPlayer.startPlayback(audioFilename: self.audioFilename)
                    self.isPlaying = true
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }.sheet(isPresented: self.$isPlaying) {
                    SpectrogramView(spectrogramFilename: self.spectrogramFilename)
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                    self.isPlaying = false
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            }
        }
    }
}

struct RecordingsList: View {

    @ObservedObject var audioRecorder: AudioRecorder

    var body: some View {
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioFilename: recording.audioFilename,
                             spectrogramFilename: recording.spectrogramFilename)
            }
        }
    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList(audioRecorder: AudioRecorder())
    }
}
