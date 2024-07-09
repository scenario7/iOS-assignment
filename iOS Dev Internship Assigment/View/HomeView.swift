//
//  SwiftUIView.swift
//  iOS Dev Internship Assigment
//
//  Created by Kevin Thomas on 09/07/24.
//

import SwiftUI
import AVKit

struct HomeView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.gray, .white], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                VStack(spacing:20){
                    Text("Hey, I'm Kevin!")
                        .foregroundStyle(.black)
                        .font(.system(size: 40, weight: .bold, design: .serif))
                    Text("And this is my completed assignment")
                        .foregroundStyle(.black)
                        .font(.system(size: 15, weight: .semibold, design: .default))
                    NavigationLink {
                        if let url = Bundle.main.url(forResource: "test", withExtension: "mov"){
                            MainView(player: AVPlayer(url: url))
                        }
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundColor(.black.opacity(0.6))
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(width: 50, height: 50)
                    }


                }
            }
        }
    }
}

#Preview {
    HomeView()
}
