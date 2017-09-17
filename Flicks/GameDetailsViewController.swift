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
    var summary: String!
    var gameTitle: String!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailsPosterImage: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = gameTitle
        
        summaryLabel.text = summary
        summaryLabel.sizeToFit()
        
        // Configure scrollView
        let contentWidth = scrollView.bounds.width
        let contentHeight = infoView.frame.origin.y + infoView.frame.height + 20

        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        detailsPosterImage.setImageWith(posterURL!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
