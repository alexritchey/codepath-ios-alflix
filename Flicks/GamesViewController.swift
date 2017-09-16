//
//  ViewController.swift
//  Flicks
//
//  Created by Alex Ritchey on 9/11/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let endpoint: String! = "now_playing"
    let apiKey = "4114a5b37eacab862e1924b0ffb9ae8e"
    let apiUrl: URL! = URL(string: "https://api-2445582011268.apicast.io/games/?fields=name,popularity,summary,cover&order=popularity:desc")
    
    var games: [Game]?

    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hook up Refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: UIControlEvents.valueChanged)
        gameTableView.insertSubview(refreshControl, at: 0)
        
        // Load initial data
        loadData()
        
        gameTableView.delegate = self
        gameTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Segue to Details
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameDetailsViewController
        let indexPath = gameTableView.indexPath(for: sender as! UITableViewCell)
        let idx: Int! = indexPath?.row
        let game = games![idx]
        
        vc.gameTitle = game.title
        vc.posterURL = game.posterURL
        vc.summary = game.overview
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return game count, if nil return 0
        return games?.count ?? 0
    }
    
    // Table Cell Configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let game = games![indexPath.row]
        // dequeueReusableCell allows app to re-use cells
        let cell = gameTableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell

        cell.titleLabel.text = game.title
        cell.overviewLabel.text = game.overview
        cell.posterView.setImageWith(game.posterURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // TODO: Refactor loadData and refreshData to use a common function
    func loadData() {
        var request = URLRequest(url: apiUrl)
        request.addValue(apiKey, forHTTPHeaderField: "user-key")
        request.addValue("application/json", forHTTPHeaderField: "Accepts")
        
        let session = URLSession(
            configuration: .default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )

        MBProgressHUD.showAdded(to: self.view, animated: true)
        let task = session.dataTask(with: request) { (maybeData, response, error) in
            if let data = maybeData {
                let obj = try! JSONSerialization.jsonObject(with: data, options: [])
                if let gameDicts = obj as? [NSDictionary] {
                    self.games = gameDicts.map({ (game) -> Game in
                        return Game(gameDict: game)
                    })
                }
                MBProgressHUD.hide(for: self.view, animated: true)
                self.errorLabel.isHidden = true
                self.gameTableView.reloadData()
            } else {
                self.errorLabel.isHidden = false
            }
        }

        task.resume()
    }
    
    // TODO: Refactor loadData and refreshData to use a common function
    func refreshData(_ refreshControl: UIRefreshControl) {
        var request = URLRequest(url: apiUrl)
        request.addValue(apiKey, forHTTPHeaderField: "user-key")
        request.addValue("application/json", forHTTPHeaderField: "Accepts")
        
        let session = URLSession(
            configuration: .default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task = session.dataTask(with: request) { (maybeData, response, error) in
            if let data = maybeData {
                let obj = try! JSONSerialization.jsonObject(with: data, options: [])
                if let gameDicts = obj as? [NSDictionary] {
                    self.games = gameDicts.map({ (game) -> Game in
                        return Game(gameDict: game)
                    })
                }
                self.gameTableView.reloadData()
                refreshControl.endRefreshing()
                self.errorLabel.isHidden = true
            } else {
                self.errorLabel.isHidden = false
            }
        }
        
        task.resume()
    }

}

