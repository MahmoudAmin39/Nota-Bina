//
//  Note.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 10/30/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum NoteColor : String {
    case Black
    case Red
    case Blue
    case Green
    case Orange
    
    var color: UIColor {
        switch self {
        case .Red:
            return UIColor.red
        case .Blue:
            return UIColor.blue
        case .Green:
            return UIColor.green
        case .Orange:
            return UIColor.orange
        case .Black:
            return UIColor.black
        }
    }
}

enum NoteFont : String {
    case Normal
    case Italic
    case Bold
    
    var font: UIFont {
        switch self {
        case .Bold:
            return UIFont.boldSystemFont(ofSize: 20.0)
        case .Italic:
            return UIFont.italicSystemFont(ofSize: 20.0)
        case .Normal:
            return UIFont.preferredFont(forTextStyle: .title3)
        }
    }
}

struct Note {
    let id: String
    let body: String
    let creationDate: Date
    let textColorName: String
    let textStyleName: String
    
    var shortDate: String? {
        return DateFormatter.localizedString(from: creationDate, dateStyle: .short, timeStyle: .short)
    }
}

extension Note {
    init?(withManaged object: NSManagedObject) {
        let id = object.value(forKey: "id") as? String
        let body = object.value(forKey: "body") as? String
        let creattionDate = object.value(forKey: "creationDate") as? Date
        let textColorName = object.value(forKey: "colorName") as? String
        let textStyleName = object.value(forKey: "fontName") as? String
        
        guard let noteId = id, let noteBody = body, let noteCreationDate = creattionDate, let noteTextColor = textColorName, let noteTextStyle = textStyleName else { return nil }
        self = Note(id: noteId, body: noteBody, creationDate: noteCreationDate, textColorName: noteTextColor, textStyleName: noteTextStyle)
    }
}

