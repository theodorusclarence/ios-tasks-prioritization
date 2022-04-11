//
//  TaskDetailViewController.swift
//  mc1-team-10
//
//  Created by Clarence on 11/04/22.
//

import UIKit

protocol TaskDetailViewControllerDelegate {
    func passOnEdit()
}

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var timerMethodControl: UISegmentedControl!
    @IBOutlet weak var methodHelpLabel: UILabel!
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    var task: TaskItem?
    var delegate: TaskDetailViewControllerDelegate?
    
    let flowtimeHelp =  NSMutableAttributedString()
        .normal("Flowtime is great for task that needs ")
        .bold("a longer period of thinking time ")
        .normal("and")
        .bold(" uses your creativity to finish. ")
        .normal("\n\nEnjoy your task ")
        .bold("without interruption")
        .normal(" while still considering your break time.")
    
    
    let pomodoroHelp = NSMutableAttributedString()
        .normal("Pomodoro is great for task that is ")
        .bold("a chore")
        .normal(" and ")
        .bold("repetitive.")
        .normal("\n\nForce yourself to finish the task by ")
        .bold("weaving your work and break time.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editPullDownButton = UIButton()
        editPullDownButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        
        let edit = UIAction(title: "Edit Task", image: UIImage(systemName: "pencil"), handler: { _ in self.didTapEdit() })
        let delete = UIAction(title: "Delete Task", image: UIImage(systemName: "trash"), attributes: .destructive ,handler: { _ in self.didTapDelete() })
        let menu = UIMenu(children: [edit, delete])
        editPullDownButton.menu = menu
        
        editPullDownButton.showsMenuAsPrimaryAction = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editPullDownButton)
        tabBarController?.tabBar.isHidden = true
        
        methodHelpLabel.attributedText = flowtimeHelp
        
        updateContents()
    }
    
    func updateContents() {
        taskNameLabel.text = task?.taskName ?? "Task Name"
        statusLabel.text = task?.status ?? "Status"
        dueDateLabel.text = (task?.dueDate != nil) ? DateHelper().getStringDate(task!.dueDate!) : ""
    }
    
    @objc func didTapEdit() {
        let controller = (storyboard?.instantiateViewController(withIdentifier:"EditTaskVC")) as! EditTaskViewController
        controller.task = task
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func didTapDelete() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let taskToDelete = task {
            context.delete(taskToDelete)
        }
        
        do {
            try context.save()
            delegate?.passOnEdit()
            navigationController?.popViewController(animated: true)
        } catch {
            
        }
    
    }
    
    @IBAction func timerMethodChanges(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            methodHelpLabel.attributedText = flowtimeHelp
        } else {
            methodHelpLabel.attributedText = pomodoroHelp
        }
    }
    
    @IBAction func didTapFinishTask(_ sender: UIButton) {
        
    }
}


extension TaskDetailViewController: EditTaskViewControllerDelegate {
    func onEdit() {
        updateContents()
        delegate?.passOnEdit()
    }
}
