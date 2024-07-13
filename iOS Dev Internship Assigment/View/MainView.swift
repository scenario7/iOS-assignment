//
//  MainView.swift
//  iOS Dev Internship Assigment
//
//  Created by Kevin Thomas on 09/07/24.
//

import SwiftUI
import AVKit

struct MainView: View {
    
    @State var currentWord = ""
    @State var player : AVPlayer
    @State var subtitles = true
    @State var showTranscript = false
    
    
    @ObservedObject var subtitleManager = SubtitleManager()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment:.bottom){
                    VideoPlayer(player: player)
                        .cornerRadius(20)
                        .onAppear(perform: {
                            startSubtitleTracking()
                        })
                    if (subtitles) {
                        Text(currentWord)
                            .foregroundStyle(.yellow)
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .padding(40)
                            .multilineTextAlignment(.center)
                    }
                }
                HStack{
                    Button {
                        print("")
                        subtitles.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(subtitles ? .green.opacity(0.3) : .red.opacity(0.3))
                                .cornerRadius(10)
                            Text("Subtitles : \(subtitles ? "On" : "Off")")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(subtitles ? .green : .red)
                        }
                        .frame(height: 50)
                    }
                    Spacer()
                    Button {
                        showTranscript.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.blue.opacity(0.3))
                                .cornerRadius(10)
                            Text("View Transcript")
                                .font(.system(size: 15, weight: .semibold))
                        }
                        .frame(height: 50)
                    }
                    
                }
                .padding()
            }
            .onAppear(perform: {
                subtitleManager.loadSubtitles()
            })
            .padding()
            .navigationTitle("Result")
            .sheet(isPresented: $showTranscript, content: {
                TranscriptView(paragraphs: subtitleManager.alternatives[0].paragraphs)
            })
        }
    }
    
    func startSubtitleTracking() {
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1.5, preferredTimescale: 600), queue: .main) { time in
            let currentTime = CMTimeGetSeconds(time)
            updateSubtitle(for: (currentTime + 0.5)) // I added an offset because the words were lagging
        }
    }
    
    func updateSubtitle(for time: Double) {
        var possibleWords: [Word] = []
        for subtitle in subtitleManager.alternatives[0].words {
            if (subtitle.start - 0.75) <= time && (subtitle.end + 0.75) >= time { // updated this to show 1.5 seconds worth of subtitles
                possibleWords.append(subtitle)
            }
        }
        if !possibleWords.isEmpty {
            currentWord = possibleWords.map { $0.word }.joined(separator: " ")
        } else {
            currentWord = ""
        }
    }
}

#Preview {
    MainView( player: AVPlayer(url: Bundle.main.url(forResource: "test", withExtension: "mov")!))
        .previewInterfaceOrientation(.landscapeLeft)
}
