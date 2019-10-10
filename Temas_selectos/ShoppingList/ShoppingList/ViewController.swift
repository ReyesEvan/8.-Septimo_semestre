//
//  ViewController.swift
//  ToDoList
//
//  Created by UDLAP11 on 9/20/19.
//  Copyright © 2019 UDLAP11. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var todos = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func addItem(item: String) {
        todos.add(item)
        savePlist()
    }
    
    func loadPlist() {
        let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let path = documentsDir.appendingPathComponent("Data.plist")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: path) {
            if let bundlePath = Bundle.main.path(forResource: "Data", ofType: "plist") {
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                }
                catch {
                    print("Error loading plist")
                }
            }
        }
        todos = NSMutableArray(contentsOfFile: path)!
        tableView.reloadData()
    }
    
    func savePlist() {
        let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let path = documentsDir.appendingPathComponent("Data.plist")
        todos.write(toFile: path, atomically: false)
        self.loadPlist()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoList", for: indexPath) as UITableViewCell
        cell.textLabel?.text = (todos[indexPath.row] as! String)
        cell.imageView?.image = UIImage(named: todos[indexPath.row] as! String)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            savePlist()
        }
    }
}
