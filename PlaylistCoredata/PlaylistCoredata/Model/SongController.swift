//
//  SongController.swift
//  PlaylistCoredata
//
//  Created by Hin Wong on 3/4/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import Foundation
import CoreData

class SongController {
    
   //MARK: - CRUD
    func createSong(with artist: String, title: String, playlist: Playlist) {
        Song(artist: artist, title: title, playlist: playlist)
    }
    
    func deleteSong(song: Song) {
        CoreDataStack.context.delete(song)
        PlaylistController.sharedInstance.saveToPersistentStore()
    }
    
}// End of class
