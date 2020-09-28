//
//  ViewController.swift
//  Test
//
//  Created by Cleís Aurora Pereira on 27/09/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewCustom: UITableView!
    let myarray = ["Mônica", "Magali", "Cebolinha", "Cascão"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCustom.delegate = self
        tableViewCustom.dataSource = self
    }

    // MARK: - UITableViewDataSource conforms

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myarray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = myarray[indexPath.row]
        return cell
    }
}

