//
//  PlayerView.swift
//  MusicApp
//
//  Created by jb on 2020/10/07.
//

import Foundation
import SwiftUI
import AVFoundation
import Firebase

struct PlayerView: View{
    @State
    var album: Album
    
    @State
    var song: Song
    
    @State
    var player = AVPlayer()
    
    @State
    var isPlaying: Bool = false
    
    var body: some View{
        ZStack{
            Image(album.image).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                AlbumArt(album: album, isWithText: false)
                Text(song.name).font(.title).fontWeight(.light).foregroundColor(.white)
                Spacer()
                ZStack {
                    Color.white.cornerRadius(20).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    HStack{
                        Button(action: self.previous, label: {
                            Image(systemName: "arrow.left.circle")
                                .resizable()
                        })
                        .frame(width: 70, height: 70, alignment: .center)
                        .foregroundColor(Color.black.opacity( 0.2))
                        
                        
                        Button(action: self.playPause, label: {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                        }).frame(width: 70, height: 70, alignment: .center)
                        
                        
                        Button(action: self.next, label: {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                        })
                        .frame(width: 70, height: 70, alignment: .center)
                        .foregroundColor(Color.black.opacity( 0.2))
                    }
                }.edgesIgnoringSafeArea(.bottom).frame(height: 200, alignment: .center)
            }
        }.onAppear(){
            self.playSong()
        }
        
    }
    
    func playSong(){
        let storage = Storage.storage().reference(forURL: self.song.file)
        storage.downloadURL { (url, error) in
            if error != nil {
                print(error)
            }else{
                do{
                    //let music work despit of ringer
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                }catch{
                    //report for an error
                }
                player = AVPlayer(url: url!)
                player.play()
            }
        }
    }
    
    func playPause(){
        self.isPlaying.toggle()
        if isPlaying == false{
            player.pause()
        }else{
            player.play()
        }
    }
    func next(){
        if let currentIndex = album.songs.firstIndex(of: song){
            if currentIndex == album.songs.count - 1{
                //do nothing
            }else{
                player.pause()
                song = album.songs[currentIndex+1]
                self.playSong()
            }
        }
    }
    func previous(){
        if let currentIndex = album.songs.firstIndex(of: song){
            if currentIndex == 0 {
                //do nothing
            }else{
                player.pause()
                song = album.songs[currentIndex-1]
                self.playSong()
            }
        }
    }
}

