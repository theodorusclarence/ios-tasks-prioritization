//
//  AddTaskViewController.swift
//  mc1-team-10
//
//  Created by Clarence on 08/04/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelModal))
        
        navBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: nil)
    }
    
    @objc func cancelModal() {
        dismiss(animated: true)
    }
    
    
    
}
