//
//  DMSong.swift
//  DropMusic2
//
//  Created by Angel Contreras on 11/27/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class DMSong: DMMediaItem{
    let title: String
    let artist: String
    let albumName: String
    let collectionID: Double?
    var storeID: Double
    var albumCoverStringURL: String
    let trackTime: Int
    var mediaType: String = "track"
    
    init(title: String, artist: String, collectionID: Double? = nil, albumName: String, storeID: Double, albumCoverStringURL: String, trackTime: Int){
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
        
        guard let storeIDDictionary = idDictionary["attributes"] as? [String: Double] else { return nil }
        self.storeID = storeIDDictionary["im:id"]!
        
        guard let collectionNameDictionary = albumNameDictionary["im:name"] as? [String: String] else { return nil }
        self.albumName = collectionNameDictionary["label"]!
        
        let lastArrayValue = trackTimeArrayOfDictionaries.last
        let durationDictionary = lastArrayValue?["im:duration"] as? [String: Int]
        self.trackTime = (durationDictionary?["label"])!
        
        self.collectionID = nil
        
        let lastImageDictionary = arrayOfImageDictionary.last
        self.albumCoverStringURL =  lastImageDictionary?["label"] as! String
    }
}
