//
//  CreateItemViewController.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 12/01/2022.
//

import UIKit
import CoreData

class CreateItemViewController: UIViewController {

    @IBOutlet weak var textField : UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
 //MARK: -  Add new Item 
    @IBAction func addButtonPressed(_ sender: Any) {
        let newItem = Item()
        newItem.date = "14.10.2022"
        newItem.category = "Job"
        newItem.title = "Fire Bob"
        newItem.done = false
        itemArray.append(newItem)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
