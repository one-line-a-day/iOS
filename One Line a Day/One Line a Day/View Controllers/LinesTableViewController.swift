//
//  NotesTableViewController.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class LinesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        prevButton.isHidden = true
        nextButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
        
        lineController.fetchLines { (error) in
            if let error = error {
                NSLog("Could not fetch data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateViews()
            }
        }
    }
    
    private func updateViews() {
        guard let oldLine = lineController.lines.last else {
            oldestLine.text = "\"You don't have a line. \n Let's change that.\""
            return }
        
        oldestLine.text = "\"\(oldLine.line)\""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Feb 2019"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = #colorLiteral(red: 0.1801737547, green: 0.1791095138, blue: 0.1809961498, alpha: 1)
        header.contentView.backgroundColor = #colorLiteral(red: 0.8860269189, green: 0.3269340992, blue: 0.3611180782, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineController.lines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineCell", for: indexPath) as! LineTableViewCell
        
        let line = lineController.lines[indexPath.row]
        cell.line = line
        cell.backgroundColor = #colorLiteral(red: 0.9985807538, green: 0.9596754909, blue: 0.9514060616, alpha: 1)
        cell.selectionStyle = .none
    
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
                    self.updateViews()
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateLine" {
            guard let destination = segue.destination as? LineDetailViewController else { return }
            
            destination.lineController = lineController
        } else if segue.identifier == "ViewLine" {
            guard let destination = segue.destination as? LineDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destination.lineController = lineController
            destination.line = lineController.lines[indexPath.row]
        }
    }
    
    
    // MARK: - Properties
    
    let lineController = LineController()
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var oldestLine: UILabel!
    
}
