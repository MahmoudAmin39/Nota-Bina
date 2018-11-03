//
//  AddAndEditNoteViewController.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 10/29/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import UIKit

class AddAndEditNoteViewController: UIViewController {
    
    @IBOutlet weak var noteBodyLabel: UITextView!
    @IBOutlet weak var buttonsBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    let presenter = NoteDetailsPresenter()
    
    var attributes = [NSAttributedString.Key : Any]() {
        didSet {
            let attributedText = NSAttributedString(string: noteBodyLabel.text, attributes: attributes)
            noteBodyLabel.attributedText = attributedText
        }
    }
    
    var textColor: UIColor? {
        didSet {
            attributes[.foregroundColor] = textColor
            attributes[.font] = UIFont.preferredFont(forTextStyle: .title3)
        }
    }
    
    var textColorName = "Black" {
        didSet {
            textColor = NoteColor(rawValue: textColorName)?.color
        }
    }
    
    var textFontStyle: UIFont? {
        didSet {
            attributes[.font] = textFontStyle
        }
    }
    
    var textStyleName = "Normal" {
        didSet {
            textFontStyle = NoteFont(rawValue: textStyleName)?.font
        }
    }
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let note = note {
            noteBodyLabel.text = note.body
            textColorName = note.textColorName
            textStyleName = note.textStyleName
        } else {
            shareButton.isEnabled = false
            deleteButton.isEnabled = false
        }
    }
    
    @IBAction func saveNoteAndDismiss(_ sender: Any) {
        if noteBodyLabel.text.isEmpty {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        guard let id = note?.id else {
            presenter.addNote(with: noteBodyLabel.text, and: textColorName, and: textStyleName) { [weak self] (note, error) in
                if error == nil, let strongSelf = self, let listViewController = strongSelf.navigationController?.viewControllers[0] as? NotesTableViewController {
                        listViewController.notes.insert(note, at: 0)
                        listViewController.tableView.reloadData()
                        strongSelf.navigationController?.popViewController(animated: true)
                }
            }
            return
        }
        
        presenter.editNote(which: id, with: noteBodyLabel.text, and: textColorName, and: textStyleName) { [weak self] (note, error) in
            if error == nil, let strongSelf = self {
                if let listViewController = strongSelf.navigationController?.viewControllers[0] as? NotesTableViewController, let index = listViewController.tableView.indexPathForSelectedRow?.row {
                    listViewController.notes[index] = note
                    strongSelf.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
        if let id = note?.id {
            presenter.deleteNote(which: id) { [weak self] (error) in
                if error == nil, let strongSelf = self {
                    if let listViewController = strongSelf.navigationController?.viewControllers[0] as? NotesTableViewController, let index = listViewController.tableView.indexPathForSelectedRow?.row {
                        listViewController.notes.remove(at: index)
                        strongSelf.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func shareNote(_ sender: Any) {
        let shareVC = UIActivityViewController(activityItems: [note?.body as Any], applicationActivities: nil)
        present(shareVC, animated: true, completion: nil)
    }
    
    @IBAction func colorClicked(_ button: UIButton) {
        if let buttonText = button.titleLabel?.text {
            textColorName = buttonText
        }
    }
    
    @IBAction func styleClicked(_ button: UIButton) {
        if let buttonText = button.titleLabel?.text {
            textStyleName = buttonText
        }
    }
}
