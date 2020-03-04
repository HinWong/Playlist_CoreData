//
//  SongDetailViewController.swift
//  PlaylistCoredata
//
//  Created by Hin Wong on 3/4/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {
    
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var songTextField: UITextField!
    @IBAction func songAddButtonTapped(_ sender: Any) {
        guard let playlist = playlist, let artistName = artistTextField.text, let songTitle = songTextField.text else {return}
        SongController.createSong(with: artistName, title: songTitle, playlist: playlist )
        
    }
    @IBOutlet weak var songTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTableView.delegate = self
        songTableView.dataSource = self
    }
    
    //MARK:- Properties
    var playlist: Playlist? = nil

}//End of class

extension SongDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let playlist = self.playlist else {return 0}
        
        return playlist.songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        guard let playlist = self.playlist else {return UITableViewCell()}
        if let song = playlist.songs?[indexPath.row] as? Song {
            cell.textLabel?.text = song.title
            cell.detailTextLabel?.text = song.title
        }
        return cell
        }
        
}//End of extension

extension SongDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete that guy
            guard let playlist = playlist else { return }
            guard let song = playlist.songs?[indexPath.row] as? Song else { return }
            SongController.deleteSong(song: song)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}//End of extension

