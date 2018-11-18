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
    
 private var episodes = GOTEpisode.allEpisodes
    override func viewDidLoad() {
    super.viewDidLoad()
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = episodeTableView.indexPathForSelectedRow,
            let episodeDetails = segue .destination as? EpisodeDetails else {return}
        let episode = episodes[indexPath.row]
       episodeDetails.episode = episode
    }

}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let episode = episodes[indexPath.row]
        switch episode.season {
        case 1,3,5,7:
            let episode = episodes[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeOverviewCell", for: indexPath) as? episodeOverviewCell else { fatalError("episode not found")}
            cell.secondImageView.image = UIImage.init(named: episode.mediumImageID)
            cell.episodeName.text = episode.name
            cell.episodeInfo.text = " S : \(episode.season) E: \(episode.number)"
            return cell
        case 2,4,6:
         guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "SecondOverviewCell", for: indexPath) as? secondOverviewCell else { fatalError("episode not found")}
         let episode = episodes[indexPath.row]
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
