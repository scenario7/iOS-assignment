//
//  TranscriptView.swift
//  iOS Dev Internship Assigment
//
//  Created by Kevin Thomas on 09/07/24.
//

import SwiftUI

struct TranscriptView: View {
    
    var paragraphs : Paragraphs
    
    var body: some View {            
            ForEach(paragraphs.paragraphs){ paragraph in
                VStack{
                    Text(paragraph.sentences.map { $0.text }
                        .joined(separator: " "))
                        .multilineTextAlignment(.leading)
                }
                .padding()
            }
    }
}

