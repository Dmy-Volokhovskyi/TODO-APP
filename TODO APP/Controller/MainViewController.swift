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

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellReuseId, for: indexPath) as! MainTableViewCell
        cell.done.text = String(itemArray[indexPath.row].done)
        cell.name.text = itemArray[indexPath.row].title
        cell.date.text = itemArray[indexPath.row].date
        cell.category.image = K.imageArray[Int(itemArray[indexPath.row].imageIndex)]
        cell.backgroundColor = K.colorArray[Int(itemArray[indexPath.row].colorIndex)]
        if itemArray[indexPath.row].done {
            cell.done.text = "✓"
        }else {
            cell.done.text = " "
        }
        // Configure the cell...
        cell.cellIndex = indexPath.row
        cell.parentVC = self
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    func loadTODOItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
           itemArray =  try context.fetch(request)
        }catch {
            print ( "Error fetching data \(error)" )
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        loadTODOItems()
        tableView.reloadData()
        chekForData()
        
    }
    func saveItems() {
        do {
          try context.save()
            print(itemArray)
        }catch{
            print("Error saving Context \(error)")
        }
    }
    func deleteItems (Index: Int?){
        context.delete(itemArray[Index ?? 0])
        saveItems()
        itemArray.remove(at: Index!)
        tableView.reloadData()
    }
    
    @objc func refresh() {
        
        
        loadTODOItems()
        self.tableView.reloadData() // a refresh the tableView.
        chekForData()

    }
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
