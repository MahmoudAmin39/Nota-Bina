//
//  AddAndEditNoteViewController.swift
//  Nota Bina
//
//  Created by Grapes'n'Berries on 10/29/18.
//  Copyright © 2018 Tryvin. All rights reserved.
//

import UIKit

class AddAndEditNoteViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveNoteAndDismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
