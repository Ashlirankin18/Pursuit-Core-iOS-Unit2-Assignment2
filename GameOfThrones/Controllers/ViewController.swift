//
//  ViewController.swift
//  GameOfThrones
//
//  Created by Alex Paul on 11/16/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var episodeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var episodes = GOTEpisode.allEpisodes {
        didSet {
            episodeTableView.reloadData()
        }
    }
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
       searchBar.delegate = self
        setupRefreshControl()
        
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = episodeTableView.indexPathForSelectedRow,
            let episodeDetails = segue .destination as? EpisodeDetails else {return}
        let episode = episodes[indexPath.section][indexPath.row]
       episodeDetails.episode = episode
    }
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        episodeTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getEpisodes), for: .valueChanged)
    }
    
    @objc private func getEpisodes() {
        refreshControl.endRefreshing()
        episodes = GOTEpisode.allEpisodes
    }
}
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
       return episodes.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return episodes[section].count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Season 1"
        case 1:
            return "Season 2"
        case 2:
            return "Season 3"
        case 3:
            return "Season 4"
        case 4:
            return "Season 5"
        case 5:
            return "Season 6"
        case 6:
            return "Season 7"
        default:
            return "invalid"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let episode = episodes[indexPath.section][indexPath.row]
        switch episode.season {
        case 2,4,6:
            let episode = episodes[indexPath.section][indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeOverviewCell", for: indexPath) as? episodeOverviewCell else { fatalError("episode not found")}
            cell.secondImageView.image = UIImage.init(named: episode.mediumImageID)
            cell.episodeName.text = episode.name
            cell.episodeInfo.text = " S : \(episode.season) E: \(episode.number)"
            return cell
        case 1,3,5,7:
         guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "SecondOverviewCell", for: indexPath) as? secondOverviewCell else { fatalError("episode not found")}
         let episode = episodes[indexPath.section][indexPath.row]
         cell2.overViewImage.image = UIImage.init(named: episode.mediumImageID)
         cell2.episodeName.text = episode.name
         cell2.episodeInfo.text = "S : \(episode.season) E: \(episode.number)"
            return cell2
        default:
             fatalError("unknown")
        }
        
}
   
}
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        let episodes1 = episodes.flatMap{$0}
        episodes = [episodes1.filter{$0.name.lowercased().contains(searchText.lowercased())}]
        
}
    }

