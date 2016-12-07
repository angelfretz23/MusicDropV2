//
//  DMAlbum.swift
//  DropMusic2
//
//  Created by Angel Contreras on 11/27/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class DMAlbum: DMMediaItem, Equatable{
    let title: String
    let artist: String
    let coverURL: String
    var storeID: String
    var songs: [DMSong]?
    var mediaType: String = "collection"
    
    init(title: String, artist: String, coverURL: String, storeID: String){
        self.title = title
        self.artist = artist
        self.coverURL = coverURL
        self.storeID = storeID
    }
    
    init(withSong song: DMSong){
        self.title = song.albumName
        self.artist = song.artist
        self.songs = []
        self.coverURL = song.albumCoverStringURL
        self.storeID = song.collectionID!
    }
   
    func isEqualTo(other: DMMediaItem) -> Bool {
        guard let other = other as? DMAlbum else { return false}
        return self.storeID == other.storeID
    }
}

func ==(left: DMAlbum, right: DMAlbum) -> Bool {
    return left.storeID == right.storeID
}
