//
//  SettingsViewController.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q  on 1/3/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    lazy var loadNumLabel: UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        lab.text = "You have loaded \(UserDefaultsHelper.manager.getNumberOfImageLoads()) images"
       return lab
    }()
    
    lazy var nameEntryTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 300, width: 300, height: 200))
        tf.text = UserDefaultsHelper.manager.getSavedName() ?? "Enter name here"
        return tf
    }()
    
    lazy var saveNameButton: UIButton = {
        let but = UIButton(frame: CGRect(x: 0, y: 550, width: 100, height: 100))
        but.setTitle("Save Name", for: .normal)
        but.addTarget(self, action: #selector(saveName), for: .touchUpInside)
        but.backgroundColor = .green
        return but
    }()
    
    @objc func saveName() {
        if let newName = nameEntryTextField.text {
            UserDefaultsHelper.manager.save(name: newName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        [loadNumLabel, nameEntryTextField, saveNameButton].forEach{self.view.addSubview($0)}
    }
}
