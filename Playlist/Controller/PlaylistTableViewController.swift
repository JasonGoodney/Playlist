//
//  PlaylistTableViewController.swift
//  Playlist
//
//  Created by Jason Goodney on 8/22/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var playlistTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - View Updates
    func updateView() {
        setupTextField(playlistTextField)
        setUPUI()
    }
    
    func setupTextField(_ textField: UITextField) {
        textField.autocapitalizationType = .words
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PlaylistController.shared.playlists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)

        let playlist = PlaylistController.shared.playlists[indexPath.row]
        let numberOfSongs = playlist.songs.count
        
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "Song's \(numberOfSongs)"

        return cell
    }
 
 
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlistToDelete = PlaylistController.shared.playlists[indexPath.row]
            
            do {
                try PlaylistController.shared.deletePlaylist(playlistToDelete)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } catch let error {
                print("Error removing \(playlistToDelete.name)\nAt \(index) with error \(error).")
            }
            
        }
    }
    
    // MARK: - Visual effect
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let clearColor = UIColor.clear
        cell.backgroundColor = UIColor(white: 1, alpha: 0.2)
        cell.textLabel?.backgroundColor = clearColor
        cell.detailTextLabel?.backgroundColor = clearColor
        
    }
    
    // MARK: - Actions
    @IBAction func addPlaylistButtonTapper(_ sender: UIBarButtonItem) {
        if let playlistName = playlistTextField.text, !playlistName.isEmpty {
            PlaylistController.shared.createPlaylist(name: playlistName)
            playlistTextField.resignFirstResponder()
            tableView.reloadData()
            playlistTextField.text = ""
        }
   
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSongsVC" {
            let destinationVC = segue.destination as? SongsTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC?.playlist = PlaylistController.shared.playlists[indexPath.row]
            
            if playlistTextField.isFirstResponder {
                playlistTextField.resignFirstResponder()
            }
        }
    }
 

}

extension PlaylistTableViewController {
    
    // MARK: - UI
    
    func setUPUI() {
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "sunsetSki"))
        tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
        
        // Make a blur effect
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        imageView.clipsToBounds = true
    }
}
