//
//  MainViewController.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 12/01/2022.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = [Item](){
        didSet{
            
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTODOItems()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return itemArray.count
    }
      // Filling with cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellReuseId, for: indexPath) as! MainTableViewCell
        // Configure the cell...
        cell.done.text = String(itemArray[indexPath.row].done)
        cell.name.text = itemArray[indexPath.row].title
        cell.date.text = itemArray[indexPath.row].date
        cell.category.image = K.imageArray[Int(itemArray[indexPath.row].imageIndex)]
        cell.backgroundColor = K.colorArray[Int(itemArray[indexPath.row].colorIndex)]
        if itemArray[indexPath.row].done {
            cell.done.text = "✓"
        }else if itemArray[indexPath.row].isImportant {
            cell.done.text = "🔥"
        }else {
            cell.done.text = ""
        }
        if Int(itemArray[indexPath.row].imageIndex) == 0{
            cell.category.image = K.imageArray[Int(itemArray[indexPath.row].imageIndex)]?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
        cell.cellIndex = indexPath.row
        cell.parentVC = self
        cell.layer.cornerRadius = 15
        
        return cell
    }
    // making sure we update the view every time we see it
    override func viewDidAppear(_ animated: Bool) {
        loadTODOItems()
        tableView.reloadData()
        chekForData()
        
    }
    // MARK: functions to work with data
    func loadTODOItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
           itemArray =  try context.fetch(request)
        }catch {
            print ( "Error fetching data \(error)" )
        }
    }
    func saveItems() {
        do {
          try context.save()
        }catch{
            print("Error saving Context \(error)")
        }
    }
    
    // Function to refresh data after ParentVC deletes items From cell
    @objc func refresh() {
        loadTODOItems()
        self.tableView.reloadData() // a refresh the tableView.
        chekForData()

    }
    // Function to show an aller if Items array is empty.
    func chekForData(){
        if itemArray == []{
            let alert = UIAlertController(title: "You seem to have no TODO Items ", message: "", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Create new TODO Item", style: UIAlertAction.Style.destructive, handler: { action in
                self.performSegue(withIdentifier: K.segueCreate, sender: MainViewController.self)

            }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}
