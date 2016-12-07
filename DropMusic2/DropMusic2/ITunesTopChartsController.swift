//
//  ITunesTopChartsController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/6/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class TopChartsController{
    
    let baseURL = URL(string: "https://itunes.apple.com/us/rss/topsongs/limit=25/json")
    
    func fetchSongs(completion: @escaping (_ songs: [DMSong]) -> Void){
        guard let url = baseURL else { return }
        
        NetworkController.performRequest(for: url, httpMethodString: .get) { (data, error) in
            guard let data = data,
                let responseDataString = String.init(data: data, encoding: String.Encoding.utf8) else { completion([]); return }
            
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            } else if responseDataString.contains("error") {
                print("Error: \(responseDataString)")
            }
            
            let jsonFromData = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any]
            guard let feedDictionary = jsonFromData?["feed"] as? [String: Any] else { return }
            guard let topSongsArrayOfDictionaries = feedDictionary["entry"] as? [[String: Any]] else {completion([]); return }
            
            let songs = topSongsArrayOfDictionaries.flatMap{ DMSong(dictionaryTopCharts: $0)}
            DispatchQueue.main.async {
                completion(songs)
            }
        }
    }
}
