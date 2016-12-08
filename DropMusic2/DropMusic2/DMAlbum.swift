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
    let releaseDate: String?
    let copyrights: String?
    var songs: [DMSong]?
    var mediaType: String = "collection"
    
    init?(dictionary: [String: Any]){
        guard let title = dictionary["collectionName"] as? String,
            let releaseDate = dictionary["releaseDate"] as? String,
            let artist = dictionary["artistName"] as? String,
            let copyrights = dictionary["copyright"] as? String,
            let storeID = dictionary["collectionId"] as? Double,
            let coverURL = dictionary["artworkUrl100"] as? String
            else { return nil }
        self.title = title
        self.artist = artist
        self.releaseDate = releaseDate
        self.copyrights = copyrights
        self.storeID = storeID.cleanValue
        self.songs = []
        self.coverURL = coverURL
    }

    init(withSong song: DMSong){
        self.title = song.albumName
        self.artist = song.artist
        self.songs = []
        self.coverURL = song.albumCoverStringURL
        self.storeID = song.collectionID!
        
        self.releaseDate = nil
        self.copyrights = nil
    }
   
    func isEqualTo(other: DMMediaItem) -> Bool {
        guard let other = other as? DMAlbum else { return false}
        return self.storeID == other.storeID
    }
}

func ==(left: DMAlbum, right: DMAlbum) -> Bool {
    return left.storeID == right.storeID
}
