//
//  SongsTableViewController.swift
//  Playlist
//
//  Created by Jason Goodney on 8/22/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import UIKit

class SongsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    var playlist: Playlist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    // MARK: - View Updates
    func updateView() {
        setupTextField(artistTextField)
        setupTextField(titleTextField)
    }
    
    func setupTextField(_ textField: UITextField) {
        textField.autocapitalizationType = .words
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return playlist?.songs.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)

        if let song = playlist?.songs[indexPath.row] {
            cell.textLabel?.text = song.artist
            cell.detailTextLabel?.text = song.title
        }

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let playlist = playlist else { return }
            let song = playlist.songs[indexPath.row]
            
            do {
                try SongController.shared.remove(song, fromPlaylist: playlist)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error {
                print("Error removing \(song.title) by \(song.artist)\nAt \(index) with error \(error).")
            }
        }   
    }
    
    // MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: UIBarButtonItem) {
        if let artist = artistTextField.text, !artist.isEmpty,
            let title = titleTextField.text, !title.isEmpty {
            
            guard let playlist = playlist else { return }

            SongController.shared.addSong(title, by: artist, toPlaylist: playlist)
            
            tableView.reloadData()
            
            artistTextField.text = ""
            titleTextField.text = ""
            titleTextField.resignFirstResponder()
        }
    }
}
