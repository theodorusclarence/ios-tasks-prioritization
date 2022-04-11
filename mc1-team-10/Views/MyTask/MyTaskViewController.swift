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
    @IBOutlet weak var addButton: UIButton!
    
    var filteredTasks: [TaskItem] = []
    let navbarTitle = UILabel()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var tasks = [TaskItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadItems()
        
        filteredTasks = tasks
        
        navbarTitle.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        navbarTitle.text = "My Tasks"
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let controller = (storyboard?.instantiateViewController(withIdentifier:"AddTaskVC")) as! AddTaskViewController
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    func filterTasks(_ statusIndex: Int) {
        switch statusIndex {
        case 0:
            filteredTasks = tasks
            // Unlisted
        case 1:
            filteredTasks = tasks.filter {$0.taskStatus == .unlisted && $0.isFinished == false }
            // Finished
        case 2:
            filteredTasks = tasks.filter {$0.isFinished == true }
            
        default:
            filteredTasks = tasks
        }
    }
    
    @IBAction func sectionChanged(_ sender: UISegmentedControl) {
        filterTasks(sender.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    func loadItems() {
        do {
            tasks = try context.fetch(TaskItem.fetchRequest())
            filterTasks(sectionControl.selectedSegmentIndex)
            
            // Anything UI Related must be run on the main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // Handle error
        }
    }
    
}

extension MyTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me! \(String(describing: filteredTasks[indexPath.row].taskName))")
        print("status \(String(describing: filteredTasks[indexPath.row].status))")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let taskDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "TaskDetailViewController") as? TaskDetailViewController else { return };
        let task = filteredTasks[indexPath.row]
        taskDetailVC.task = task
        taskDetailVC.delegate = self
        self.navigationController?.pushViewController(taskDetailVC, animated: true)
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
        cell.dueDate.text = (task.dueDate != nil) ? DateHelper().getStringDate(task.dueDate!) : ""
        
        return cell
    }
}

extension MyTaskViewController: AddTaskViewControllerDelegate, TaskDetailViewControllerDelegate {
    func onSave() {
        loadItems()
    }
    
    func passOnEdit() {
        loadItems()
    }
}
