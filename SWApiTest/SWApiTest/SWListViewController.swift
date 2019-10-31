//
//  SWApiView.swift
//  SWApiTest
//
//  Created by User on 10/30/19.
//  Copyright © 2019 Bogdan Sorobei. All rights reserved.
//

import UIKit


class SWListViewController: UITableViewController {

    let apiURL = "https://swapi.co/api/"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData ()
    }

    func fetchData () {
        request { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            do {
            let response = try decoder.decode(Links.self, from: data)
            print(response)
            } catch {
                print(error)
            }
        }
    }

    func request(completition: @escaping (Data?, Error?) -> Void) {

        guard let url = URL(string: apiURL) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completition(data, error)
            }
        }
        task.resume()
    }
    

}
