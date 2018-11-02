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
    
    var note: Note? {
        didSet {
            if let noteToPresent = note {
                noteBodyLabel.text = noteToPresent.body
                noteDateLabel.text = noteToPresent.shortDate
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
