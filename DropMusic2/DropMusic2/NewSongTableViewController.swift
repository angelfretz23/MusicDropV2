//
//  NewSongTableViewController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/6/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class NewSongTableViewController: UITableViewController {
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var newSongLabel: UILabel!
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var song: DMSong?{
        didSet{
            if let song = self.song{
                didSelectSong(song: song)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.delegate = self
        let chosenNameNotificationName = Notification.Name(rawValue: "chosenSong")
        NotificationCenter.default.addObserver(self, selector: #selector(updateWith(notification:)), name: chosenNameNotificationName, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.song != nil{
            setUpPostBarButton()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if newSongLabel.isHidden{
            switchHiddenViews()
            song = nil
        }
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func switchHiddenViews(){
        songNameLabel.isHidden = !songNameLabel.isHidden
        artistNameLabel.isHidden = !artistNameLabel.isHidden
        albumCoverImageView.isHidden = !albumCoverImageView.isHidden
        newSongLabel.isHidden = !newSongLabel.isHidden
    }
    
    func updateWith(notification: Notification) {
        guard let song = notification.object as? DMSong else { return }
        self.song = song
    }
    
    func setUpPostBarButton(){
        let rightBarButton = UIBarButtonItem()//barButtonSystemItem: .add, target: self, action: #selector(postSong))
        rightBarButton.title = "Drop"
        rightBarButton.target = self
        rightBarButton.tintColor = UIColor.white
        rightBarButton.action = #selector(postSong)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    func postSong(){
        
        guard let song = self.song,
        let user = UserController().user else { return }
        let post = DMPost(song: song, userUUID: user.uuid, description: descriptionTextView.text)
        PostController.sharedController.createPost(post, completion: nil)
    }
}

extension NewSongTableViewController{
    func didSelectSong(song: DMSong) {
        if !newSongLabel.isHidden{
            switchHiddenViews()
        }
        songNameLabel.text = song.title
        artistNameLabel.text = song.artist
        ImageController.fetchImage(withString: song.albumCoverStringURL){ (image) in
            self.albumCoverImageView.image = image
        }
    }
}

extension NewSongTableViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.contains("\n"){
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
