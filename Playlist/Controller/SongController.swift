//
//  SongController.swift
//  Playlist
//
//  Created by Jason Goodney on 8/23/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation

class SongController {
    
    static let shared = SongController()
    
    private init() {}
    
    func addSong(_ title: String, by artist: String, toPlaylist playlist: Playlist) {
        let song = Song(title: title, artist: artist)
        playlist.songs.append(song)
        PlaylistController.shared.saveToPersistantStore()
    }
    
    func remove(_ song: Song, fromPlaylist playlist: Playlist) throws {
        guard let index = playlist.songs.index(of: song) else {
            print("Error removing song \(PlaylistController.CRUDError.removeSongError)")
            return
        }
        playlist.songs.remove(at: index)
        PlaylistController.shared.saveToPersistantStore()
    }
}
