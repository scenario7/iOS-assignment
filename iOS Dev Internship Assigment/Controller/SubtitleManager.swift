//
//  SubtitleManager.swift
//  iOS Dev Internship Assigment
//
//  Created by Kevin Thomas on 09/07/24.
//

import Foundation


class SubtitleManager : ObservableObject {
    
    @Published var alternatives : [Alternative] = []
    
    func loadSubtitles() {
        guard let url = Bundle.main.url(forResource: "response", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let subtitles = try? JSONDecoder().decode(Subtitles.self, from: data) else {
            return
        }
        alternatives = subtitles.results.channels[0].alternatives
    }
}
