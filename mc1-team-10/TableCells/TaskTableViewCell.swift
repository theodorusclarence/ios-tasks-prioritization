//
//  TaskTableViewCell.swift
//  mc1-team-10
//
//  Created by Clarence on 07/04/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {


    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var difficultyWrapper: UIView!
    
    
    func setup(_ task: TaskItem) {
        taskName.text = task.taskName
        dueDate.text = (task.dueDate != nil) ? DateHelper().getStringDate(task.dueDate!) : ""
        difficulty.text = task.difficulty
        
        let difficultyEnum = Difficulty(rawValue: difficulty.text ?? "easy")
        difficultyWrapper.layer.cornerRadius = 9
        difficultyWrapper.layer.masksToBounds = true
        
        if difficultyEnum == .hard {
            difficultyWrapper.backgroundColor = UIColor(red: 0.01, green: 0.52, blue: 0.78, alpha: 1.00)
            difficulty.textColor = UIColor(red: 0.88, green: 0.95, blue: 1.00, alpha: 1.00)
        } else if difficultyEnum == .medium {
            difficultyWrapper.backgroundColor = UIColor(red: 0.88, green: 0.95, blue: 1.00, alpha: 1.00)
            difficulty.textColor = UIColor(red: 0.05, green: 0.29, blue: 0.43, alpha: 1.00)
        } else {
            difficultyWrapper.backgroundColor = UIColor(red: 0.89, green: 0.99, blue: 1.00, alpha: 1.00)
            difficulty.textColor = UIColor(red: 0.05, green: 0.20, blue: 0.26, alpha: 1.00)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        
        // Set focus style to have corner radius
        self.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
    }

}
