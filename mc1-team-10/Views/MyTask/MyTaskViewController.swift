//
//  OneThreeFiveViewController.swift
//  mc1-team-10
//
//  Created by Clarence on 07/04/22.
//

import UIKit


class MyTaskViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var sectionControl: UISegmentedControl!
    
    var tasks: [Task] = [
        Task(taskName: "Makan", dueDate: "Due 2 January 2022", status: .finished),
        Task(taskName: "Minum", dueDate: "Due 3 January 2022", status: .one),
        Task(taskName: "Ngerjain", dueDate: "Due 4 January 2022", status: .three),
        Task(taskName: "Tidur", dueDate: "Due 5 January 2022", status: .five),
        Task(taskName: "Apa", dueDate: "Due 6 January 2022", status: .finished),
        Task(taskName: "Tidur 1", dueDate: "Due 5 January 2022", status: .unlisted),
        Task(taskName: "Tidur 2", dueDate: "Due 5 January 2022", status: .unlisted),
        Task(taskName: "Tidur 3", dueDate: "Due 5 January 2022", status: .unlisted),
    ]
    
    var filteredTasks: [Task] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.delegate = self
        tableView.dataSource = self
        
        filteredTasks = tasks
    }
    
    @IBAction func sectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                filteredTasks = tasks
            // Unlisted
            case 1:
                filteredTasks = tasks.filter {$0.status == .unlisted }
            // Finished
            case 2:
                filteredTasks = tasks.filter {$0.status == .finished }
                
            default:
                filteredTasks = tasks
        }
        tableView.reloadData()
    }
    
}

extension MyTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 68
        }
}

extension MyTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task", for: indexPath) as! TaskTableViewCell
        
        let task = filteredTasks[indexPath.row]
        cell.taskName.text = task.taskName
        cell.dueDate.text = task.dueDate
        
        return cell
    }
}

