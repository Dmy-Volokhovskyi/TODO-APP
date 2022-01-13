//
//  CreateItemViewController.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 12/01/2022.
//

import UIKit
import CoreData

class CreateItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    

    @IBOutlet weak var textField : UITextField!
    
    @IBOutlet weak var categorySelectionTable: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category](){
        didSet{
            
            categorySelectionTable.reloadData()
        }
    }
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        categorySelectionTable.dataSource = self
        categorySelectionTable.delegate = self
        super.viewDidLoad()
        loadITODOtems()
        print(datePicker.date)
        loadICategorytems()
        
    
        // Do any additional setup after loading the view.
    }
    
 //MARK: -  Add new Item 
    @IBAction func addButtonPressed(_ sender: Any) {
        let newItem = Item(context: context)
        newItem.date = "14.10.2022"
        newItem.category = "Job"
        newItem.title = "Fire Bob"
        newItem.done = false
        itemArray.append(newItem)
        saveItems()
        
    }
    func saveItems() {
        do {
          try context.save()
            print(itemArray)
        }catch{
            print("Error saving Context \(error)")
        }
    }
    func loadITODOtems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
           itemArray =  try context.fetch(request)
        }catch {
            print ( "Error fetching data \(error)" )
        }
    }
    func loadICategorytems() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
           categoryArray =  try context.fetch(request)
        }catch {
            print ( "Error fetching data \(error)" )
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCell, for: indexPath) as! CategoryTableViewCell
        cell.categoryTitle.text = categoryArray[indexPath.row].name ?? " Hello"
        cell.colorImage.backgroundColor = .green
        cell.emojiLabel.text =  "Smile"
        // Configure the cell...

        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        loadICategorytems()
        loadITODOtems()
    }
}
