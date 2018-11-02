//
//  NoteTableViewCell.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 11/2/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteBodyLabel: UILabel!
    @IBOutlet weak var noteDateLabel: UILabel!
    
    var attributes = [NSAttributedString.Key : Any]() {
        didSet {
            let attributedText = NSAttributedString(string: noteBodyLabel.text!, attributes: attributes)
            noteBodyLabel.attributedText = attributedText
        }
    }
    
    var colorText: UIColor? {
        didSet {
            attributes[.foregroundColor] = colorText
            attributes[.font] = UIFont.preferredFont(forTextStyle: .title3)
        }
    }
    
    var textColorName = "Black" {
        didSet {
            colorText = NoteColor(rawValue: textColorName)?.color
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
                noteDateLabel.text = noteToPresent.shortDate
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
