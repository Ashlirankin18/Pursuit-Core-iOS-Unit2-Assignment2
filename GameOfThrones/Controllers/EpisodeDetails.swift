//
//  EpisodeDetails.swift
//  GameOfThrones
//
//  Created by Ashli Rankin on 11/17/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class EpisodeDetails: UIViewController {
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeSeason: UILabel!
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var episodeAirDate: UILabel!
    @IBOutlet weak var episodeSummary: UITextView!
    
    
    var episode: GOTEpisode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        
    }
    func updateUi() {
        if episode!.season % 2 == 0 {
            episodeImage.image = UIImage.init(named: episode!.originalImageID)!
            episodeName.text =  episode?.name
            episodeSeason.text = "Season: \(String(describing: episode!.season))"
            episodeNumber.text = "Episode: \(String(describing: episode!.number))"
            episodeAirDate.text = "Aired Date: \(episode!.airdate)"
            episodeSummary.text = episode?.summary
        } else {
            episodeImage.image = UIImage.init(named: episode!.originalImageID)!
            episodeName.text =  episode?.name
            episodeSeason.text = "Season: \(String(describing: episode!.season))"
            episodeNumber.text = "Episode: \(String(describing: episode!.number))"
            episodeAirDate.text = "Aired Date: \(episode!.airdate)"
            episodeSummary.text = episode?.summary
        }
    }

}
