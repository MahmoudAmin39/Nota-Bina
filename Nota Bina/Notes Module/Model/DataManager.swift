//
//  DataManager.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 11/1/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol DataManagerType {
    func getNotes(_ comletion: ([NSManagedObject]?) -> Void)
    func addNote(with body: String, and color: String, and fontStyle: String, _ completion: (Note?, Error?) -> Void)
    func editNote(which id: String, with body: String, and color: String, and fontStyle: String, _ completion: (Note?, Error?) -> Void)
}

struct DataManager : DataManagerType {
    
    var context: NSManagedObjectContext? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    func getNotes(_ comletion: ([NSManagedObject]?) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try self.context?.fetch(fetchRequest)
            comletion(notes)
        } catch _ {}
    }
    
    func addNote(with body: String, and color: String, and fontStyle: String, _ completion: (Note?, Error?) -> Void) {
        if let context = context, let entity =  NSEntityDescription.entity(forEntityName: "Note", in: context) {
            let noteObject = NSManagedObject(entity: entity, insertInto: context)
            noteObject.setValue(UUID().uuidString, forKey: "id")
            noteObject.setValue(body, forKey: "body")
            noteObject.setValue(color, forKey: "colorName")
            noteObject.setValue(fontStyle, forKey: "fontName")
            noteObject.setValue(Date(), forKey: "creationDate")
            
            do {
                try context.save()
                completion(Note(withManaged: noteObject), nil)
            } catch let error as NSError {
                completion(nil, error)
            }
        }
    }
    
    func editNote(which id: String, with body: String, and color: String, and fontStyle: String, _ completion: (Note?, Error?) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let note = try self.context?.fetch(fetchRequest)
            if let noteObject = (note?[0]) {
                noteObject.setValue(body, forKey: "body")
                noteObject.setValue(color, forKey: "colorName")
                noteObject.setValue(fontStyle, forKey: "fontName")
                try context?.save()
                completion(Note(withManaged: noteObject), nil)
            }
        } catch let error as NSError {
            completion(nil, error)
        }
    }
}
