//
//  Movie.swift
//  Flicks
//
//  Created by Alex Ritchey on 9/12/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

class Movie: NSObject {
    
    var title: String
    var releaseDate: String
    var overview: String
    var posterURL: URL
    
    init(movieDict: NSDictionary!) {
        title = movieDict["title"] as! String
        releaseDate = movieDict["release_date"] as! String
        overview = movieDict["overview"] as! String
        
        let basePath = "https://image.tmdb.org/t/p/w500"
        let posterPath = movieDict["poster_path"] as! String
        posterURL = URL(string: basePath + posterPath)!
    }
    
}
