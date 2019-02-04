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
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineCell", for: indexPath) as! LineTableViewCell
        
        
        
        return cell
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
    
    
    // MARK: - Properties
    

    @IBOutlet var tableView: UITableView!
    
}
