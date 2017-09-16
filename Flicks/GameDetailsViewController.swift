//
//  GameDetailsViewController.swift
//  Flicks
//
//  Created by Alex Ritchey on 9/14/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit
import AFNetworking

class GameDetailsViewController: UIViewController {

    var posterURL: URL?
    
    @IBOutlet weak var detailsPosterImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsPosterImage.setImageWith(posterURL!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
