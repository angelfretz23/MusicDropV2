//
//  DMPost.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/5/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation
import MapKit

class DMPost{
    let song: DMSong
    let comments: [DMComment]?
    let timestamp: Date
    let userUUID: UUID
    let location: CLLocation?
    let description: String?
    let uuid: UUID
    
    init(song: DMSong, timestamp: Date, uuid: UUID, userUUID: UUID, location: CLLocation? = nil, description: String? = nil, comments: [DMComment]? = nil){
        self.song = song
        self.timestamp = timestamp
        self.uuid = uuid
        self.userUUID = userUUID
        self.location = location
        self.description = description
        self.comments = comments
    }
}
