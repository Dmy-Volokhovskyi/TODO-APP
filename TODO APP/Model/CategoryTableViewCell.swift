//
//  CategoryTableViewCell.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 13/01/2022.
//

import UIKit
import CoreData

class CategoryTableViewCell: UITableViewCell, UIContextMenuInteractionDelegate {
   
    

    @IBOutlet weak var categoryTitle : UILabel!
    @IBOutlet weak var categoryImage : UIImageView!
    @IBOutlet weak var colorImage : UIImageView!
    @IBOutlet weak var functionBtn : UIButton!
    
    var cellIndex : Int = 1
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()
    var parentVC : UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Loading Items
        loadTODOItems()
        //Setting up Context menu
        let interaction = UIContextMenuInteraction(delegate: self)
        functionBtn.addInteraction(interaction)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func button(_ sender: UIButton) {
    }
    func saveItems() {
        do {
          try context.save()
            
        }catch{
            print("Error saving Context \(error)")
        }
    }
    func loadTODOItems() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
           categoryArray =  try context.fetch(request)
        }catch {
            print ( "Error fetching data \(error)" )
        }
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
      configurationForMenuAtLocation location: CGPoint)
      -> UIContextMenuConfiguration? {
 // setting Up the deletion functionality
      let delete = UIAction(title: "Delete",
        image: UIImage(systemName: "trash.fill"),
        attributes: [.destructive]) { action in
              let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: UIAlertController.Style.alert)
              // add the actions (buttons)
              alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { action in
                  self.loadTODOItems()
                  self.context.delete(self.categoryArray[self.cellIndex])
                  self.saveItems()
                  self.categoryArray.remove(at: self.cellIndex)
                  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataCateg"), object: nil)

              }))
          alert.addAction(UIAlertAction(title: "Cancel ", style: UIAlertAction.Style.default, handler: nil))
              // show the alert using parent VC because cell cant present an allert
          self.parentVC.present(alert, animated: true, completion: nil)
       }
       return UIContextMenuConfiguration(identifier: nil,
         previewProvider: nil) { _ in
         UIMenu(title: "", children: [delete])
       }
          // MARK: Functions to work with data
    }
}
