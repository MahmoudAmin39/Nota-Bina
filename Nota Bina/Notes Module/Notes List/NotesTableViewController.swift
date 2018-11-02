//
//  NotesTableViewController.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 10/29/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    // Optional note object because it is initialized with NSManagedObject through a failable init
    var notes: [Note?] = []
    let notesListPresenter = NotesListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        notesListPresenter.getNotes { (optionalNotes) in
            self.notes.append(contentsOf: optionalNotes)
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell,
            let note = notes[indexPath.row] {
            cell.note = note
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? AddAndEditNoteViewController {
            switch segue.identifier {
            case "EditNoteSegue":
                if let indexPath = tableView.indexPathForSelectedRow, let note = notes[indexPath.row] {
                    detailViewController.title = "Edit Note"
                    detailViewController.note = note
                }
            default:
                detailViewController.title = "Add new Note"

            }
        }
    }
}
