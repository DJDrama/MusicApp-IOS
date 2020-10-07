//
//  MusicAppApp.swift
//  MusicApp
//
//  Created by jb on 2020/10/07.
//

import SwiftUI
import Firebase

@main
struct MusicAppApp: App {
    let data = OurData()
    init(){
        //init Firebase
        FirebaseApp.configure()
        data.loadAlbums()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}
