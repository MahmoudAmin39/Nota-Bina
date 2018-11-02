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
    
    var note: Note? {
        didSet {
            if let noteToPresent = note {
                noteBodyLabel.text = noteToPresent.body
                textColorName = noteToPresent.textColorName
                textStyleName = noteToPresent.textStyleName
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveNoteAndDismiss(_ sender: Any) {
        presenter.savenote(with: noteBodyLabel.text, and: textColorName, and: textStyleName) { (error) in
            if error == nil {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
