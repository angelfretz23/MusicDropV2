//
//  ItunesSearchTableViewController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/6/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class ItunesSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let itunesTopChartsContoller = ITunesTopChartsController()
    var searchController: UISearchController?
    let itunesSearchController = ItunesSearchController()
    
    var songs:[DMSong] = []{
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableViewHeader()
        setupSerachController()
        
        itunesTopChartsContoller.fetchSongs { (songs) in
            self.songs = songs
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topChartsCell", for: indexPath) as? TopChartsTableViewCell
        
        let song = songs[indexPath.row]
        cell?.updateCellWith(song: song, at: indexPath.row + 1)
        
        
        return cell ?? TopChartsTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itunesChartLabel = UILabel()
        itunesChartLabel.text = "iTunes Charts"
        itunesChartLabel.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1.0)
        itunesChartLabel.font = itunesChartLabel.font.withSize(24.0)
        itunesChartLabel.frame.size = CGSize(width: 210, height: 29)
        itunesChartLabel.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.85)
        
        let top25SongsLabel = UILabel()
        top25SongsLabel.text = "Top 25 Songs"
        top25SongsLabel.textColor = UIColor(red: (67/255), green: (191/255), blue: (254/255), alpha: 1.0)
        top25SongsLabel.font = top25SongsLabel.font.withSize(18.0)
        top25SongsLabel.frame.size = CGSize(width: 113, height: 21)
        top25SongsLabel.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.85)
        
        let verticalStackView = UIStackView(arrangedSubviews: [itunesChartLabel, top25SongsLabel])
        verticalStackView.axis = .vertical
        verticalStackView.frame.size = CGSize(width: itunesChartLabel.frame.size.width, height: 70)
        
        return verticalStackView
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "iTunes Top 25 Songs"
    }
    
    // MARK: - SearchController
    func setupSerachController(){
        
        let resultsTVC = UIStoryboard.init(name: "NewSongStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "resultsTVC")
        
        searchController = UISearchController(searchResultsController: resultsTVC)
        
        guard let searchController = searchController else { return }
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search iTunes"
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
    }
    
    func setUpTableViewHeader(){
        let itunesChartLabel = UILabel()
        itunesChartLabel.text = "iTunes Charts"
        itunesChartLabel.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1.0)
        itunesChartLabel.font.withSize(24.0)
        itunesChartLabel.frame.size = CGSize(width: 210, height: 29)
        
        let top25SongsLabel = UILabel()
        top25SongsLabel.text = "Top 25 Songs"
        top25SongsLabel.textColor = UIColor(red: (67/255), green: (191/255), blue: (254/255), alpha: 1.0)
        top25SongsLabel.font.withSize(18.0)
        top25SongsLabel.frame.size = CGSize(width: 113, height: 21)
        
        let verticalStackView = UIStackView(arrangedSubviews: [itunesChartLabel, top25SongsLabel])
        verticalStackView.axis = .vertical
        
        tableView.tableHeaderView?.addSubview(verticalStackView)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

extension ItunesSearchTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text, let resultsTVC = searchController?.searchResultsController as? ResultsTableViewController else { return }
        
        itunesSearchController.fetchSongs(with: term){ (songs) in
            resultsTVC.songs = self.itunesSearchController.arrayOfItuneObjects
            resultsTVC.tableView.reloadData()
        }
    }
}
