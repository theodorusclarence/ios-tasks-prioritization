//
//  EditTaskViewController.swift
//  mc1-team-10
//
//  Created by Clarence on 11/04/22.
//

import UIKit


protocol EditTaskViewControllerDelegate {
    func onEdit()
}

class EditTaskViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var difficultySelect: UISegmentedControl!
    @IBOutlet weak var dueDateSelect: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate: EditTaskViewControllerDelegate?
    var task: TaskItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelModal))
        navBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapAdd))
        
        taskNameField.delegate = self
        
        // Event listener for enabling buttons
        addButton.isEnabled = false
        navBar.topItem?.rightBarButtonItem?.isEnabled = false
        taskNameField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        taskNameField.becomeFirstResponder()
        difficultySelect.addTarget(self, action: #selector(closeKeyboard), for: .valueChanged)
        dueDateSelect.addTarget(self, action: #selector(closeKeyboard), for: .valueChanged)
        
        // Set default values
        taskNameField.text = task?.taskName
        switch task?.taskDifficulty {
            case .easy:
                difficultySelect.selectedSegmentIndex = 0
            case .medium:
                difficultySelect.selectedSegmentIndex = 1
            case .hard:
                difficultySelect.selectedSegmentIndex = 2
            default:
                difficultySelect.selectedSegmentIndex = 0
        }
        dueDateSelect.date = task?.dueDate ?? Date()
    }
    
    @objc func closeKeyboard() {
        print("touch")
        self.view.endEditing(true)
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
    
    @IBAction func didTapAdd(_ sender: UIButton) {
        task?.taskName = taskNameField.text
        task?.difficulty = difficultySelect.titleForSegment(at: difficultySelect.selectedSegmentIndex)?.lowercased()
        task?.dueDate = dueDateSelect.date
        task?.taskStatus = .unlisted
        
        // Save it to the database
        do {
            try context.save()
            
        } catch {
            
        }
        
        // trigger delegate on MyTaskViewController
        delegate?.onEdit()
        
        dismiss(animated: true)
    }
}


extension EditTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }
}
