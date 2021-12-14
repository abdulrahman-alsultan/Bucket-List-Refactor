//
//  ViewController.swift
//  Bucket List
//
//  Created by admin on 13/12/2021.
//

import UIKit
import CoreData



class BucketListViewController: UITableViewController, AddItemViewControllerDelegate {
        
    
    var items = [BucketListItem]()
    
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        
        do{
            let result = try manageObjectContext.fetch(request)
            items = result as! [BucketListItem]
        }catch{
            print("Something went wrong")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LLostItemCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].text!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem{
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
        }
        else if sender is NSIndexPath{
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            
            addItemTableViewController.item = items[indexPath.row].text!
            addItemTableViewController.indexPath = indexPath
        }
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath{
            let item = items[ip.row]
            item.text = text
        }
        else{
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: manageObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        
        do{
            try manageObjectContext.save()
        }catch{
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

}

