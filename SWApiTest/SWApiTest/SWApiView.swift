//
//  SWApiView.swift
//  SWApiTest
//
//  Created by User on 10/30/19.
//  Copyright © 2019 Bogdan Sorobei. All rights reserved.
//

import UIKit
struct Links: Decodable {
    var people: String
    var planets: String
    var films: String
    var species: String
    var vehicles: String
    var starships: String
}

class SWApiView: UITableViewController {

    let apiURL = "https://swapi.co/api/"

    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetcher ()
    }

    func dataFetcher () {
        request { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let response = try? decoder.decode(Links.self, from: data)
            print(response)
        }
    }

    func request(completition: @escaping (Data?, Error?) -> Void) {

        guard let url = URL(string: apiURL) else {return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completition(data, error)
            }
        }
        task.resume()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
