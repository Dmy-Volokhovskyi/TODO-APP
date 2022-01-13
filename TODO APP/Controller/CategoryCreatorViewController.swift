//
//  CategoryCreatorViewController.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 13/01/2022.
//

import UIKit
import CoreData

class CategoryCreatorViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var colorSelectionPicker: UICollectionView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()
    var cellCollection = [ColorPickerCollectionViewCell]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSelectionPicker.dataSource = self
        colorSelectionPicker.delegate = self
        print(K.colorArray.count)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func addButtonPressed(_ sender: Any) {
       let newCategory = Category(context: context)
        newCategory.name = "Work"
        newCategory.image = "none"
        newCategory.color = "white"
        saveItems()
        
    }
    func saveItems() {
        do {
          try context.save()
            print(categoryArray)
        }catch{
            print("Error saving Context \(error)")
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        K.colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell..
        let cell = colorSelectionPicker.dequeueReusableCell(withReuseIdentifier: K.colorPickerCell, for: indexPath) as! ColorPickerCollectionViewCell
        cell.layer.cornerRadius = 8
        cell.colorImage.backgroundColor = K.colorArray[indexPath.row]
        cellCollection.append(cell)
     
        return cell
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
         for cell in cellCollection {
             cell.colorImage.image = nil
             cell.isSelected = false
         }
         cellCollection[indexPath.row].colorImage.image = UIImage(systemName: "checkmark.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
         
         cell?.isSelected = true
    }
    
    
}

