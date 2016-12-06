//
//  ITunesSearchController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/6/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class ItunesSearchControllers{
    let baseURL = URL(string: "https://itunes.apple.com/search?")
    var parameters = ["entity": "song", "limit": "25"]
    
    var songs: [DMSong] = []{
        didSet{
            makeAlbumsFromSongs()
        }
    }
    
    var arrayOfItuneObjects: [DMMediaItem] = []
    
    func fetchSongs(with term: String, completion: @escaping (_ songs: [DMSong]?)-> Void){
        guard let url = baseURL else { completion(nil); return }
        
        parameters["term"] = term
        
        NetworkController.performRequest(for: url, httpMethodString: .get, urlParameters: parameters, body: nil) { (data, error) in
            guard let data = data,
                let responseDataString = String.init(data: data, encoding: String.Encoding.utf8) else { completion(nil); return }
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if responseDataString.contains("error") {
                print("Error: \(responseDataString)")
            }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                let resultsDictinary = jsonDictionary["results"] as? [[String:Any]] else { completion(nil); return }
            
//            let songs = resultsDictinary.flatMap{ Song(dictionaryItunesSearch: $0) }
            self.songs = songs

            DispatchQueue.main.async {
                completion(songs)
            }
        }
    }
    
    func makeAlbumsFromSongs(){
        arrayOfItuneObjects = []
        
        if songs.count > 10 {
            for x in 0...9{
                let song = songs[x]
                arrayOfItuneObjects.append(song as DMMediaItem)
            }
        } else {
            for song in songs{
                arrayOfItuneObjects.append(song as DMMediaItem)
            }
        }
        
        for song in songs{
            print(song.imageURL)
            let albumFromSong = Album(withSong: song) as DMMediaItem
            if !arrayOfItuneObjects.contains(where: {$0 == albumFromSong}) {
                arrayOfItuneObjects.append(albumFromSong)
            }
        }
    }
    
}
