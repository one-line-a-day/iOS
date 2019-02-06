//
//  NotesTableViewController.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class LinesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        
        lineController.fetchLines { (error) in
            if let error = error {
                NSLog("Could not fetch data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineController.lines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineCell", for: indexPath) as! LineTableViewCell
        
        let line = lineController.lines[indexPath.row]
        cell.line = line
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let line = lineController.lines[indexPath.row]
        
        if editingStyle == .delete {
            lineController.delete(line: line) { (error) in
                if let error = error {
                    NSLog("Could not delete entry: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateLine" {
            guard let destination = segue.destination as? LineDetailViewController else { return }
            
            destination.lineController = lineController
        }
    }
    
    
    // MARK: - Properties
    
    let lineController = LineController()
    
    @IBOutlet var tableView: UITableView!
}
