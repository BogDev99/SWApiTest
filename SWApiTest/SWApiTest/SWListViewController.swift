//
//  SWApiView.swift
//  SWApiTest
//
//  Created by User on 10/30/19.
//  Copyright © 2019 Bogdan Sorobei. All rights reserved.
//

import UIKit


class SWListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let apiURL = "https://swapi.co/api/starships"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData ()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private var content: [Starship] = []

    func fetchData () {
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

    func request(completion: @escaping (Data?, Error?) -> Void) {

        guard let url = URL(string: apiURL) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = content[indexPath.row].name
        cell.detailTextLabel?.text = content[indexPath.row].starshipClass
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(content[indexPath.row])
    }
}


