//
//  SWApiView.swift
//  SWApiTest
//
//  Created by User on 10/30/19.
//  Copyright © 2019 Bogdan Sorobei. All rights reserved.
//

import UIKit

class SWListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let apiURL = "https://swapi.co/api/starships"
    private var content: [Starship] = []
    private var starship: Starship?
    private var filtredStarshis = [Starship]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    private func fetchData() {
        request { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            do {
                let response = try decoder.decode(StarshipResponse.self, from: data)
                guard let starships = response.results else { return }
                self.content = starships
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

    private func request(completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: apiURL) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SWDetailsViewController" {
            if let viewController = segue.destination as? SWDetailsViewController {
                viewController.starship = starship
            }
        }
    }
}

extension SWListViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filtredStarshis = content.filter({ (starship: Starship) -> Bool in
            return (starship.name?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        var starhips: Starship
        
        if isFiltring {
            starhips = filtredStarshis[indexPath.row]
        } else {
            starhips = content[indexPath.row]
        }
        
        cell.textLabel?.text = content[indexPath.row].name
        cell.detailTextLabel?.text = content[indexPath.row].starshipClass
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltring {
            return filtredStarshis.count
        }
        return content.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        // TODO: -
        starship = content[indexPath.row]
        performSegue(withIdentifier: "SWDetailsViewController", sender: self)
        print(starship)
    }
}


