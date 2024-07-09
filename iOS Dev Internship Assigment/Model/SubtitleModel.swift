//
//  SubtitleModel.swift
//  iOS Dev Internship Assigment
//
//  Created by Kevin Thomas on 06/07/24.
//

import Foundation


struct Subtitles: Codable {
    let results: Results
}

struct Results: Codable {
    let channels: [Channel]
}

struct Channel: Codable {
    let alternatives: [Alternative]
}

struct Alternative: Codable {
    let transcript: String
    let confidence: Double
    let words: [Word]
    let paragraphs: Paragraphs
}

struct Paragraphs: Codable {
    let transcript: String
    let paragraphs: [Paragraph]
}

struct Paragraph: Codable, Identifiable {
    let id = UUID()
    let sentences: [Sentence]
    let numWords: Int
    let start, end: Double

    enum CodingKeys: String, CodingKey {
        case sentences
        case numWords = "num_words"
        case start, end
    }
}

struct Sentence: Codable {
    let text: String
    let start, end: Double
}

struct Word: Codable {
    let word: String
    let start, end, confidence: Double
    let punctuatedWord: String

    enum CodingKeys: String, CodingKey {
        case word, start, end, confidence
        case punctuatedWord = "punctuated_word"
    }
}
