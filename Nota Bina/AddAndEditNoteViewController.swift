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
    
    var attributes = [NSAttributedString.Key : Any]() {
        didSet {
            let attributedText = NSAttributedString(string: noteBodyLabel.text, attributes: attributes)
            noteBodyLabel.attributedText = attributedText
        }
    }
    
    var textColor: UIColor? {
        didSet {
            attributes[.foregroundColor] = textColor
        }
    }
    
    var textFontStyle: UIFont? {
        didSet {
            attributes[.font] = textFontStyle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveNoteAndDismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func colorClicked(_ button: UIButton) {
        
        switch button.titleLabel?.text {
        case "Red": textColor = UIColor.red
        case "Blue": textColor = UIColor.blue
        case "Green": textColor = UIColor.green
        case "Orange": textColor = UIColor.orange
        default: textColor = UIColor.black
        }
    }
    
    @IBAction func styleClicked(_ button: UIButton) {
        switch button.titleLabel?.text {
        case "Bold": textFontStyle = UIFont.boldSystemFont(ofSize: 18)
        case "Italic": textFontStyle = UIFont.italicSystemFont(ofSize: 18)
        default: textFontStyle = UIFont.preferredFont(forTextStyle: .title3)
        }
    }
    
}
