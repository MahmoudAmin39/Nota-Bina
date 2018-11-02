//
//  File.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 11/1/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import Foundation

protocol NotesListPresenterType {
    
    func getNotes(_ comletion: ([Note?]) -> Void)
}

class NotesListPresenter: NotesListPresenterType {
    
    let dataManager = DataManager()
    
    func getNotes(_ comletion: ([Note?]) -> Void) {
        dataManager.getNotes { (noteObjects) in
            let notes = noteObjects?.map({ Note.init(withManaged: $0)}).sorted(by: { (firstNote, secondNote) -> Bool in
                return (firstNote?.creationDate)! > (secondNote?.creationDate)!
            })
            if let notes = notes {
                comletion(notes)
            }
        }
    }
}
