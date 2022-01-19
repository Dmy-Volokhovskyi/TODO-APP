//
//  MainTableViewCell.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 12/01/2022.
//

import UIKit
import CoreData

class MainTableViewCell: UITableViewCell, UIContextMenuInteractionDelegate {
    @IBOutlet weak var date : UILabel!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var done : UILabel!
    @IBOutlet weak var category : UIImageView!
    @IBOutlet weak var functionBtn : UIButton!
    
    var cellIndex : Int = 1
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = [Item]()
    var parentVC : UIViewController!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Loading Items
        loadTODOItems()
        //Setting up Context menu
        let interaction = UIContextMenuInteraction(delegate: self)
        functionBtn.addInteraction(interaction)
    }
   // Connecting button responsible for menue triggering
    @IBAction func funcBtnPressed (_ sender: Any) {
    }
    //MARK: Setting up Context menu and 3 buttons
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
      configurationForMenuAtLocation location: CGPoint)
      -> UIContextMenuConfiguration? {
       
      let favorite = UIAction(title: "Set Important",
          image: UIImage(systemName: "flame.circle")) { [self] _ in
          self.done.text = "🔥"
          itemArray[self.cellIndex].isImportant = true
          itemArray[self.cellIndex].done = false
      }
      let done = UIAction(title: "Set Done",
            image: UIImage(systemName: "checkmark.circle")) { _ in
              self.done.text = "✓"
          self.itemArray[self.cellIndex].isImportant = false
          self.itemArray[self.cellIndex].done = true
          }
 // setting Up the deletion functionality
      let delete = UIAction(title: "Delete",
        image: UIImage(systemName: "trash.fill"),
        attributes: [.destructive]) { action in
              let alert = UIAlertController(title: "Are you sure?", message: " ", preferredStyle: UIAlertController.Style.alert)
              // add the actions (buttons)
              alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { action in
                  self.context.delete(self.itemArray[self.cellIndex])
                  self.saveItems()
                  self.itemArray.remove(at: self.cellIndex)
                  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)

              }))
          alert.addAction(UIAlertAction(title: "Cancel ", style: UIAlertAction.Style.default, handler: nil))
              // show the alert using parent VC because cell cant present an allert
          self.parentVC.present(alert, animated: true, completion: nil)
       }
       return UIContextMenuConfiguration(identifier: nil,
         previewProvider: nil) { _ in
         UIMenu(title: "", children: [favorite, done, delete])
       }
          // MARK: Functions to work with data 
    }
    func saveItems() {
        do {
          try context.save()
            print(itemArray)
        }catch{
            print("Error saving Context \(error)")
        }
    }
    func loadTODOItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
           itemArray =  try context.fetch(request)
        }catch {
            print ( "Error fetching data \(error)" )
        }
    }
}
