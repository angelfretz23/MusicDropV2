//
//  DMAlbum.swift
//  DropMusic2
//
//  Created by Angel Contreras on 11/27/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class DMAlbum: DMMediaItem{
    let title: String
    let artist: String
    let coverURL: String
    var storeID: Double
    var songs: [DMSong]?
    var mediaType: String = "collection"
    
    init(title: String, artist: String, coverURL: String, storeID: Double){
        self.title = title
        self.artist = artist
        self.coverURL = coverURL
        self.storeID = storeID
    }
}
