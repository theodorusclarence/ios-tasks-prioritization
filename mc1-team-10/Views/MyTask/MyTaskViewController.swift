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
    
//    var tasks: [Task] = [
//        Task(taskName: "Makan", dueDate: "Due 2 January 2022", status: .finished),
//        Task(taskName: "Minum", dueDate: "Due 3 January 2022", status: .one),
//        Task(taskName: "Ngerjain", dueDate: "Due 4 January 2022", status: .three),
//        Task(taskName: "Tidur", dueDate: "Due 5 January 2022", status: .five),
//        Task(taskName: "Apa", dueDate: "Due 6 January 2022", status: .finished),
//        Task(taskName: "Tidur 1", dueDate: "Due 5 January 2022", status: .unlisted),
//        Task(taskName: "Tidur 2", dueDate: "Due 5 January 2022", status: .unlisted),
//        Task(taskName: "Tidur 3", dueDate: "Due 5 January 2022", status: .unlisted),
//    ]
    
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
        let controller = storyboard?.instantiateViewController(withIdentifier:"AddTaskVC")
        self.present(controller!, animated: true, completion: {  print("Hi") })
    }
    
    func filterTasks(_ statusIndex: Int) {
        switch statusIndex {
        case 0:
            filteredTasks = tasks
            // Unlisted
        case 1:
            filteredTasks = tasks.filter {$0.taskStatus == .unlisted }
            // Finished
        case 2:
            filteredTasks = tasks.filter {$0.taskStatus == .finished }
            
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
        print("You tapped me! \(filteredTasks[indexPath.row].taskName)")
        print("status \(filteredTasks[indexPath.row].status)")
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
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "d MMMM YYYY"
        cell.dueDate.text = (task.dueDate != nil) ? dateFormatterGet.string(from: task.dueDate!) : ""
        
        return cell
    }
}

