//
//  DMSong.swift
//  DropMusic2
//
//  Created by Angel Contreras on 11/27/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class DMSong: DMMediaItem, Equatable{
    let title: String
    let artist: String
    let albumName: String
    let collectionID: String?
    var storeID: String
    var albumCoverStringURL: String
    let trackTime: String
    var mediaType: String = "track"
    
    init(title: String, artist: String, collectionID: String? = nil, albumName: String, storeID: String, albumCoverStringURL: String, trackTime: String){
        self.title = title
        self.artist = artist
        self.albumName = albumName
        self.collectionID = collectionID
        self.storeID = storeID
        self.albumCoverStringURL = albumCoverStringURL
        self.trackTime = trackTime
    }
    
    init?(dictionaryTopCharts: [String: Any]){
        guard let songNameDictionary = dictionaryTopCharts["im:name"] as? [String: String],
            let artistDictionary = dictionaryTopCharts["im:artist"] as? [String: Any],
            let arrayOfImageDictionary = dictionaryTopCharts["im:image"] as? [[String: Any]],
            let albumNameDictionary = dictionaryTopCharts["im:collection"] as? [String: Any],
            let trackTimeArrayOfDictionaries = dictionaryTopCharts["link"] as? [[String: Any]],
            let idDictionary = dictionaryTopCharts["id"] as? [String: Any] else { return nil }
        
        self.title = songNameDictionary["label"]!
        self.artist = artistDictionary["label"] as! String
        
        guard let storeIDDictionary = idDictionary["attributes"] as? [String: String] else { return nil }
        self.storeID = storeIDDictionary["im:id"]!
        
        guard let collectionNameDictionary = albumNameDictionary["im:name"] as? [String: String] else { return nil }
        self.albumName = collectionNameDictionary["label"]!
        
        let lastArrayValue = trackTimeArrayOfDictionaries.last
        let durationDictionary = lastArrayValue?["im:duration"] as? [String: String]
        self.trackTime = (durationDictionary?["label"])!
        
        self.collectionID = nil
        
        let lastImageDictionary = arrayOfImageDictionary.last
        self.albumCoverStringURL =  lastImageDictionary?["label"] as! String
    }
    
    init?(dictionaryItunesSearch: [String:Any]){
        if dictionaryItunesSearch["kind"] as? String == "music-video"{
            return nil
        }
        
        guard let songName = dictionaryItunesSearch["trackName"] as? String,
            let artistSong = dictionaryItunesSearch["artistName"] as? String,
            let storeID = dictionaryItunesSearch["trackId"] as? Double,
            let trackTime = dictionaryItunesSearch["trackTimeMillis"] as? Double,
            let albumName = dictionaryItunesSearch["collectionName"] as? String,
            let largeImageURL = dictionaryItunesSearch["artworkUrl100"] as? String,
            let collectionID = dictionaryItunesSearch["collectionId"] as? Double else { return nil }
        
        self.title = songName
        self.artist = artistSong
        self.storeID = storeID.cleanValue
        self.trackTime = trackTime.cleanValue
        self.albumName = albumName
        self.collectionID = collectionID.cleanValue
        self.albumCoverStringURL = largeImageURL
    }
    
    func isEqualTo(other: DMMediaItem) -> Bool {
        guard let other = other as? DMSong else { return false }
        return self.storeID == other.storeID
    }
}

func ==(left: DMSong, right: DMSong) -> Bool{
    return left.storeID == right.storeID
}
