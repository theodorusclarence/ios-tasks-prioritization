//
//  TaskDetailViewController.swift
//  mc1-team-10
//
//  Created by Clarence on 11/04/22.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var timerMethodControl: UISegmentedControl!
    @IBOutlet weak var methodHelpLabel: UILabel!
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    var task: TaskItem?
    
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

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        tabBarController?.tabBar.isHidden = true
        
        methodHelpLabel.attributedText = flowtimeHelp
        
        updateContents()
    }
    
    func updateContents() {
        taskNameLabel.text = task?.taskName ?? "Task Name"
        statusLabel.text = task?.status ?? "Status"
        dueDateLabel.text = (task?.dueDate != nil) ? DateHelper().getStringDate(task!.dueDate!) : ""
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
