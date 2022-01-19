//
//  CreateItemViewController.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 12/01/2022.
//

import UIKit
import CoreData

class CreateItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var textField : UITextField!
    @IBOutlet weak var categorySelectionTable: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelBtn : UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category](){
        didSet{
            
            categorySelectionTable.reloadData()
        }
    }
    var itemArray = [Item]()
    var categoryTitle = " "
    var categoryColorIndex : Int16?
    var categoryImageIndex : Int16?
    
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        textField.delegate = self
        categorySelectionTable.dataSource = self
        categorySelectionTable.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataCateg"), object: nil)
        //load items
        loadITODOtems()
        loadICategorytems()
        // set design
        addButton.layer.cornerRadius = 8
        cancelBtn.layer.cornerRadius = 8
    }
    
 //MARK: -  Add new Item 
    @IBAction func addButtonPressed(_ sender: Any) {
        let letters = CharacterSet.letters

        let phrase = textField.text ?? " "
        let range = phrase.rangeOfCharacter(from: letters)
        
        if categoryTitle != " ", range != nil{
            let alert = UIAlertController(title: "Saved", message: "", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
                self.navigationController?.popToRootViewController(animated: true)
                self.textField.layer.borderWidth = 1
                self.textField.layer.borderColor = .init(red: 0, green: 1, blue: 0, alpha: 1)
                self.categorySelectionTable.layer.borderWidth = 1
                self.categorySelectionTable.layer.borderColor = .init(red: 0, green: 1, blue: 0, alpha: 1)
                let newItem = Item(context: self.context)
                let date = self.datePicker.date.formatted(date: .long, time: .omitted)
                newItem.category = self.categoryTitle
                newItem.title = self.textField.text
                newItem.done = false
                newItem.colorIndex = self.categoryColorIndex!
                newItem.imageIndex = self.categoryImageIndex!
                newItem.date = date
                newItem.done = false
                newItem.isImportant = false
                self.itemArray.append(newItem)
                self.saveItems()

            }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else {
            // create the alert
                    let alert = UIAlertController(title: "Can't save data", message: "The Field is empty! ", preferredStyle: UIAlertController.Style.alert)
            textField.layer.borderWidth = 1
            textField.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
            categorySelectionTable.layer.borderWidth = 1
            categorySelectionTable.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
                    // add the actions (buttons)
                    alert.addAction(UIAlertAction(title: "Fill the field ", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    //MARK: - Functions to work with data.
    func saveItems() {
        do {
          try context.save()
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
    //MARK: TableView fucntions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryColorIndex = categoryArray[indexPath.row].colorIndex
        categoryImageIndex = categoryArray[indexPath.row].imageIndex
        categoryTitle = categoryArray[indexPath.row].name!
        tableView.layer.borderWidth = 0
   }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCell, for: indexPath) as! CategoryTableViewCell
        // Configure the cell...
        let color = Int(categoryArray[indexPath.row].colorIndex)
        let image = Int(categoryArray[indexPath.row].imageIndex)
        cell.categoryTitle.text = categoryArray[indexPath.row].name ?? " Hello"
        cell.categoryImage.image = K.imageArray[image]
        cell.colorImage.backgroundColor = K.colorArray[color]
        cell.parentVC = self
        cell.cellIndex = indexPath.row
        
        //set design
        cell.colorImage.layer.cornerRadius = 8
        cell.layer.cornerRadius = 8
        
        return cell
    }
    // making sure we update data
    override func viewDidAppear(_ animated: Bool) {
        loadICategorytems()
        loadITODOtems()
    }
    // using cancel btn
    @IBAction func backToMainVC(_ sender: Any) {
        saveItems()
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func refresh() {
        loadICategorytems()
        categorySelectionTable.reloadData()
}
}

extension CreateItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
