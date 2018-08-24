//
//  Playlist.swift
//  Playlist
//
//  Created by Jason Goodney on 8/22/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation

class Playlist: Equatable, Codable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.name == rhs.name && lhs.songs == rhs.songs
    }

    let name: String
    var songs: [Song] = []
    
    // Designated init aka Default aka Memberwise
    init(name: String, songs: [Song] = []) {
        self.name = name
        self.songs = songs
    }
}


