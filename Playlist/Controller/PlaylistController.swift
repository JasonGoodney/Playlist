//
//  PlaylistController.swift
//  Playlist
//
//  Created by Jason Goodney on 8/22/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation
import UIKit

// Controller == CRUD
class PlaylistController {
    
    enum CRUDError: Error {
        case removeSongError
        case addSongError
    }
    
    // Singleton: shared instance
    // Prevents two instances reaching your variables and methods. It creates ONLY ONE instance to give you access to it's instance methods and variables
    static let shared = PlaylistController()
    
    private init() {
        self.playlists = loadFromPersistantStore()
    }
    
    // Souce of truth
    var playlists: [Playlist] = []
    
    // CREATE
    func createPlaylist(name: String) {
        let playlist = Playlist(name: name)
        playlists.append(playlist)
        saveToPersistantStore()
    }
    
    // READ
    
    // UPDATE
    
    
    // DELETE
    func deletePlaylist(_ playlistToDelete: Playlist) throws {
        if let index = playlists.index(of: playlistToDelete) {

            self.playlists.remove(at: index)
        }
        saveToPersistantStore()
    }
    
    

}

extension PlaylistController {
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filename = "playlists.json"
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        return fileURL
    }
    
    func saveToPersistantStore() {
        let je = JSONEncoder()
        
        do {
            let data = try je.encode(self.playlists)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving playlists from \(fileURL()): \(error)")
        }
    }
    
    func loadFromPersistantStore() -> [Playlist] {
        let jd = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let playlists = try jd.decode([Playlist].self, from: data)
            return playlists
        } catch let error {
            print("😱 Error loading playlists from \(fileURL()): \(error) \(error.localizedDescription) 😱")
        }
        
        return []
    }
}
