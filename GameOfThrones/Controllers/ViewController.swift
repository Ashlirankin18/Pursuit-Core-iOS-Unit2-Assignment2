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
            let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeOverviewCell", for: indexPath)
            cell.imageView?.image = UIImage.init(named: episode.mediumImageID)
            cell.textLabel?.text = episode.name
            return cell
        case 2,4,6:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "SecondOverviewCell", for: indexPath)
            cell2.imageView?.image = UIImage.init(named: episode.mediumImageID)
            cell2.textLabel?.text = episode.name
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
