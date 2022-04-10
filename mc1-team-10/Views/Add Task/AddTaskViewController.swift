//
//  AddTaskViewController.swift
//  mc1-team-10
//
//  Created by Clarence on 08/04/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var difficultySelect: UISegmentedControl!
    @IBOutlet weak var dueDateSelect: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelModal))
        navBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(didTapAdd))
        
        // Event listener for enabling buttons
        addButton.isEnabled = false
        navBar.topItem?.rightBarButtonItem?.isEnabled = false
        taskNameField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
    }
    
    @objc func cancelModal() {
        dismiss(animated: true)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let habit = taskNameField.text, !habit.isEmpty
        else {
            addButton.isEnabled = false
            navBar.topItem?.rightBarButtonItem?.isEnabled = false
            return
        }
        addButton.isEnabled = true
        navBar.topItem?.rightBarButtonItem?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let tbc = presentingViewController as! UITabBarController
        let nc = tbc.viewControllers![0] as! UINavigationController
        let vc = nc.viewControllers[0] as! MyTaskViewController
        vc.loadItems()
    }
    
    @IBAction func didTapAdd(_ sender: UIButton) {
        let newTask = TaskItem(context: context)
        newTask.taskName = taskNameField.text
        newTask.difficulty = difficultySelect.titleForSegment(at: difficultySelect.selectedSegmentIndex)?.lowercased()
        newTask.dueDate = dueDateSelect.date
        newTask.taskStatus = .unlisted
        
        // Save it to the database
        do {
            try context.save()
            
        } catch {
            
        }
        
        dismiss(animated: true)
    }
}
