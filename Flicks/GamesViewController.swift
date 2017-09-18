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

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var endpoint: String!
    let apiKey = "4114a5b37eacab862e1924b0ffb9ae8e"
    
    var games: [Game]?
    var filteredGames: [Game]?

    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewPicker: UISegmentedControl!
    
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
        
        searchBar.delegate = self
        
        filteredGames = games
        
        if (viewPicker.selectedSegmentIndex == 0) {
            gameTableView.isHidden = false
        } else if ( viewPicker.selectedSegmentIndex == 1) {
            gameTableView.isHidden = true
        }
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
        return filteredGames?.count ?? 0
    }
    
    // Table Cell Configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let game = filteredGames![indexPath.row]
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGames = searchText.isEmpty ? games! : games!.filter { (item: Game) -> Bool in
            let gameTitle = item.title
            return gameTitle.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        gameTableView.reloadData()
    }

    // TODO: Refactor loadData and refreshData to use a common function
    func loadData() {
        let urlString = "https://api-2445582011268.apicast.io/games/\(endpoint!)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
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
                    self.filteredGames = self.games
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
        let url = URL(string: "https://api-2445582011268.apicast.io/games/\(endpoint!)")
        var request = URLRequest(url: url!)
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
                    self.filteredGames = self.games
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

    @IBAction func viewPickerChanged(_ sender: Any) {
        if (viewPicker.selectedSegmentIndex == 0) {
            gameTableView.isHidden = false
        } else if ( viewPicker.selectedSegmentIndex == 1) {
            gameTableView.isHidden = true
        }
    }
}

