//
//  AlbumController.swift
//  DropMusic
//
//  Created by Angel Contreras on 10/17/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class AlbumController{
    
    private let baseURL = URL(string: "https://itunes.apple.com/lookup?")
    private var parameters = ["entity": "song"]
    
    //private var album: DMAlbum?
    
    func fetchSongsWithAlbum(ID: String, completion: @escaping (_ album: DMAlbum?) ->Void){
        guard let url = baseURL else { completion(nil); return }
        parameters["id"] = ID
        
        NetworkController.performRequest(for: url, httpMethodString: .get, urlParameters: parameters) { (data, error) in
            guard let data = data, let responseDataString = String.init(data: data, encoding: String.Encoding.utf8) else { completion(nil); return }
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if responseDataString.contains("error") {
                print("Error: \(responseDataString)")
            }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
            var resultsArrayofDictionaries = jsonDictionary["results"] as? [[String: Any]] else { completion(nil); return }
            
            let albumDictionary = resultsArrayofDictionaries.removeFirst()
            guard let album = DMAlbum(dictionary: albumDictionary) else { completion(nil); return }
            
            let songs = resultsArrayofDictionaries.flatMap{ DMSong(dictionaryItunesSearch: $0) }
            album.songs = songs
            
            DispatchQueue.main.async {
                completion(album)
            }
        }
    }
}
