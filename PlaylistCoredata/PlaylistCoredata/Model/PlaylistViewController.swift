//
//  PlaylistViewController.swift
//  PlaylistCoredata
//
//  Created by Hin Wong on 3/4/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    
    @IBOutlet weak var playlistTableView: UITableView!
    @IBAction func addButtonTapped(_ sender: Any) {
        
        guard let playlistName = playlistNameTextField.text else {return}
        PlaylistController.sharedInstance.createPlaylist(with: playlistName)
        
        playlistNameTextField.text = ""
        playlistTableView.reloadData()
    }
    @IBOutlet weak var playlistNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //IIDOO
        
        if segue.identifier == "toDetailVC" {
            
            guard let index = playlistTableView.indexPathForSelectedRow, let destinationVC = segue.destination as? SongDetailViewController else { return }
            let playlist = PlaylistController.sharedInstance.playlists[index.row]
            destinationVC.playlist = playlist
        }
    }
    

}

extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.sharedInstance.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
        
        let songCount = playlist.songs?.count ?? 0
        
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "\(playlist.songs?.count)"
        
        return cell
    }
    
}//End of extension

extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
            
            PlaylistController.sharedInstance.deletePlaylist(playlist: playlist)
            playlistTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}//End of extension
