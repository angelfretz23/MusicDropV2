//
//  AlbumDetailViewController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/7/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

protocol AlbumDetailViewControllerDelegate: class {
    func didSelect(song: DMSong)
}

class AlbumDetailViewController: UIViewController {
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var copyrightsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let album = album{
            albumController.fetchSongsWithAlbum(ID: album.storeID){ (album) in
                self.album = album
            }
            //updateWith(album: album)
        }
        
    }
    
    var album: DMAlbum?{
        didSet{
            tableView.reloadData()
            guard let album = album else { return }
            updateWith(album: album)
        }
    }
    
    let albumController = AlbumController()
    
    weak var delegate: AlbumDetailViewControllerDelegate?

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateWith(album: DMAlbum){
        albumNameLabel.text = album.title
        artistNameLabel.text = album.artist
        copyrightsLabel.text = album.copyrights
        
        let year = album.releaseDate?.components(separatedBy: "-").first
        releaseYearLabel.text = year
    }
}

extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        
        return cell
    }
}
