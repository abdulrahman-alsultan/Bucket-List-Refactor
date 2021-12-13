//
//  AddItemTableViewController.swift
//  Bucket List
//
//  Created by admin on 13/12/2021.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemViewControllerDelegate?
    @IBOutlet weak var itemTextField: UITextField!
    var item: String?
    var indexPath: NSIndexPath?
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem){
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem){
        guard let itemTxt = itemTextField.text else { return }
        delegate?.itemSaved(by: self, with: itemTxt, at: indexPath)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTextField.text = item

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    

}
