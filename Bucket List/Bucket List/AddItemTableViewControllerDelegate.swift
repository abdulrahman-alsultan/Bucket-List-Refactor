//
//  AddItemTableViewControllerDelegate.swift
//  Bucket List
//
//  Created by admin on 13/12/2021.
//

import Foundation

protocol AddItemViewControllerDelegate: AnyObject{
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddItemTableViewController)
}
