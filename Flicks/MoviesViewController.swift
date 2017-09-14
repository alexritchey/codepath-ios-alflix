//
//  ViewController.swift
//  Flicks
//
//  Created by Alex Ritchey on 9/11/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let endpoint: String! = "now_playing"
    var movies: [Movie]?

    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return movie count, if nil return 0
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies![indexPath.row]
        // dequeueReusableCell allows app to re-use cells
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell

        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.posterView.setImageWith(movie.posterURL)
        
        return cell
    }

    func loadData() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url)
        let session = URLSession(
            configuration: .default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )

        let task = session.dataTask(with: request) { (maybeData, response, error) in
            if let data = maybeData {
                let obj = try! JSONSerialization.jsonObject(with: data, options: [])
                if let responseDict = obj as? NSDictionary {
                    let movieDicts = responseDict["results"] as! [NSDictionary]
                    self.movies = movieDicts.map({ (movie) -> Movie in
                        return Movie(movieDict: movie)
                    })
                    
                    self.movieTableView.reloadData()
                    
                }
            }
        }

        task.resume()
        
    }

}

