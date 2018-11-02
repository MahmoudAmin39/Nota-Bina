//
//  NoteDetailsPresenter.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 11/1/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import Foundation

protocol NoteDetailsPresenterType {
    func savenote(with body: String, and color: String, and fontStyle: String, _ completion: (Error?) -> Void)
}

struct NoteDetailsPresenter: NoteDetailsPresenterType {
    
    let dataManager = DataManager()
    
    func savenote(with body: String, and color: String, and fontStyle: String, _ completion: (Error?) -> Void) {
        dataManager.savenote(with: body, and: color, and: fontStyle) { (error) in
            completion(error)
        }
    }
}
