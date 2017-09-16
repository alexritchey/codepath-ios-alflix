//
//  Game.swift
//  Flicks
//
//  Created by Alex Ritchey on 9/12/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

class Game: NSObject {
    
    var title: String
    var overview: String
    var posterURL: URL
    
    init(gameDict: NSDictionary!) {
        title = gameDict["name"] as! String
        overview = gameDict["summary"] as! String
        var coverPath: String
        
        if let coverDict = gameDict["cover"] as? [String:AnyObject] {
            coverPath = coverDict["url"] as! String
            let fullCover = coverPath.replacingOccurrences(of: "t_thumb", with: "t_cover_big")
            posterURL = URL(string: "https:\(fullCover)")!
        } else {
            posterURL = URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/o1yenovvskchtjrl48v5.jpg")!
        }

    }
    
}
