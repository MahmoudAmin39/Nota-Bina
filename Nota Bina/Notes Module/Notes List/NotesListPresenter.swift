//
//  File.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 11/1/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import Foundation

protocol NotesListPresenterType {
    
    func getNotes(_ comletion: ([Note?], Error?) -> Void)
    func searchNotes(forKey word: String, _ completion: ([Note?], Error?) -> Void)
}

class NotesListPresenter: NotesListPresenterType {
    
    let dataManager = DataManager()
    
    func getNotes(_ comletion: ([Note?], Error?) -> Void) {
        dataManager.getNotes { (noteObjects, error) in
            let notes = noteObjects?.map({ Note.init(withManaged: $0)}).sorted(by: {return ($0?.creationDate)! > ($1?.creationDate)!})
            if let notes = notes {
                comletion(notes, error)
            }
        }
    }
    
    func searchNotes(forKey word: String, _ completion: ([Note?], Error?) -> Void) {
        dataManager.searchNotes(forKey: word) { (notesObjects, error) in
            if error == nil {
                let notes = notesObjects?.map({Note.init(withManaged: $0)}).sorted(by: {return ($0?.creationDate)! > ($1?.creationDate)!})
                if let notes = notes {
                    completion(notes, nil)
                }
            } else {
                completion([], error)
            }
        }
    }
}
