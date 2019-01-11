//
//  ViewController.swift
//  Todo
//
//  Created by Chris Anderson on 1/10/19.
//  Copyright © 2019 Chris Anderson. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var myTodos = [Task]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Task.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       loadItems()
        
    }
    
    //MARK: - TABLEVIEW DATASOUCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTodos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        let item = myTodos[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        
        //        if myTodos[indexPath.row].done == true {
        //            cell.accessoryType = .checkmark
        //        }
        //        else {
        //            cell.accessoryType = .none
        //        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // sets boolean to opposite
        myTodos[indexPath.row].done.toggle()
        
        saveItems()
        
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //        }
        //        else {
        //        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //    }
    }
    
    @IBAction func addItemPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks add item bar button
            self.myTodos.append(Task(title: textField.text!))
            
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(myTodos)
            try data.write(to: dataFilePath!)
        }catch {
            print("Error encoding myTodo array: \(error)")
        }
        tableView.reloadData()

    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            myTodos = try decoder.decode([Task].self, from: data)
            }
            catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
    }
}

