//
//  NoteDetailsPresenter.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 11/1/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import Foundation

protocol NoteDetailsPresenterType {
    func addNote(with body: String, and color: String, and fontStyle: String, _ completion: (Note?, Error?) -> Void)
    func editNote(which id: String, with body: String, and color: String, and fontStyle: String, _ completion: (Note?, Error?) -> Void)
    func deleteNote(which id: String, _ completion: (Error?) -> Void)
}

struct NoteDetailsPresenter: NoteDetailsPresenterType {
    
    let dataManager = DataManager()
    
    func addNote(with body: String, and color: String, and fontStyle: String, _ completion: (Note?, Error?) -> Void) {
        dataManager.addNote(with: body, and: color, and: fontStyle) { (note, error) in
            completion(note, error)
        }
    }
    
    func editNote(which id: String, with body: String, and color: String, and fontStyle: String, _ completion: (Note?, Error?) -> Void) {
        dataManager.editNote(which: id, with: body, and: color, and: fontStyle) { (note, error) in
            completion(note, error)
        }
    }
    
    func deleteNote(which id: String, _ completion: (Error?) -> Void) {
        dataManager.deleteNote(which: id) { (error) in
            completion(error)
        }
    }
}
