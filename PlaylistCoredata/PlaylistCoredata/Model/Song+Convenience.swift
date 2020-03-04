//
//  Song+Convenience.swift
//  PlaylistCoredata
//
//  Created by Hin Wong on 3/4/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import Foundation
import CoreData

extension Song {
    
    convenience init (artist: String, title: String, playlist:Playlist, moc: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: moc)
        self.artist = artist
        self.title = title
        self.playlist = playlist
    }
}
