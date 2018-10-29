//
//  NotesTableViewController.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 10/29/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    let words = ["Word1", "Word2", "Word3"]
    var storyBoard: UIStoryboard?

    override func viewDidLoad() {
        super.viewDidLoad()
        storyBoard = storyboard
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath)
        cell.textLabel?.text = words[indexPath.row]
        cell.detailTextLabel?.text = words[indexPath.row]
        return cell
    }

    @IBAction func addNote(_ sender: UIBarButtonItem) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? AddAndEditNoteViewController {
            switch segue.identifier {
            case "EditNoteSegue":
                detailViewController.title = "Edit Note"
            default:
                detailViewController.title = "Add new Note"
                
            }
        }
    }
}
