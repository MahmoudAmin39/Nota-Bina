//
//  NotesTableViewController.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 10/29/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    // Optional note object because it is initialized with NSManagedObject through a failable init
    var notes: [Note?] = [] {
        didSet {
          tableView.reloadData()
        }
    }
    var tempNotes: [Note?] = []
    let notesListPresenter = NotesListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Notes"
        searchController.searchBar.delegate = self
        // Add search controller to the navigation item
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        // Fetch the notes
        notesListPresenter.getNotes { (optionalNotes) in
            self.notes.append(contentsOf: optionalNotes)
            self.tempNotes.append(contentsOf: optionalNotes)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchTerm = searchController.searchBar.text {
            if searchTerm.isEmpty { return }
            notesListPresenter.searchNotes(forKey: searchTerm) { (notes, error) in
                if error == nil {
                    self.notes = notes
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.notes = tempNotes
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
