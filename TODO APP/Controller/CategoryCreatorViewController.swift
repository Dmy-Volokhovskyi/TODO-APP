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
    @IBOutlet weak var imageSelectionPicker : UICollectionView!
    @IBOutlet weak var nameTextField : UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()
    var cellCollection = [ColorPickerCollectionViewCell]()
    var imageCollection = [ImagePickerCollectionViewCell]()
    let imageArray = K.imageArray
    var colorCellIndex = 1
    var imageCellIndex = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSelectionPicker.dataSource = self
        colorSelectionPicker.delegate = self
        imageSelectionPicker.delegate = self
        imageSelectionPicker.dataSource = self
        print(K.colorArray.count)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func addButtonPressed(_ sender: Any) {
       let newCategory = Category(context: context)
        if nameTextField.text != ""{
            newCategory.name = nameTextField.text
            newCategory.color = String(colorCellIndex)
            newCategory.image = String(imageCellIndex)
            newCategory.imageIndex = Int16(imageCellIndex)
            newCategory.colorIndex = Int16(colorCellIndex)
        }
        print(newCategory)
        saveItems()
        
    }
    
    //MARK: - Functions Responcible for Data
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
    //MARK: - Functions responcible For collections.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorSelectionPicker{
             return K.colorArray.count
        }else{
            return imageArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colorSelectionPicker{
        // Configure the cell for colors
        let cell = colorSelectionPicker.dequeueReusableCell(withReuseIdentifier: K.colorPickerCell, for: indexPath) as! ColorPickerCollectionViewCell
        cell.layer.cornerRadius = 8
        cell.colorImage.backgroundColor = K.colorArray[indexPath.row]
            // Setting up an array of sells to ease deselection 
        cellCollection.append(cell)
     
            return cell}
        //Configure cell for images
        else {
            let cell = imageSelectionPicker.dequeueReusableCell(withReuseIdentifier: K.imagePickerCell, for: indexPath) as! ImagePickerCollectionViewCell
            cell.imageIcon.image = imageArray[indexPath.row]
            // Setting up an array of sells to ease deselection
            imageCollection.append(cell)
            return cell
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if collectionView == colorSelectionPicker{
             
        let cell = collectionView.cellForItem(at: indexPath)
             //wiping out previous selection
         for cell in cellCollection {
             cell.colorImage.image = nil
             cell.isSelected = false
         }
             // Selecting the pressed collor
         cellCollection[indexPath.row].colorImage.image = UIImage(systemName: "checkmark.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
         cell?.isSelected = true
             // preparing data for transition.
         colorCellIndex = indexPath.row
             
             
         } else {
             // Working on the image selection
             let cell = collectionView.cellForItem(at: indexPath)
             // making sure we delete previous selection.
             for cell in imageCollection {
                 cell.layer.borderWidth = 0
                 cell.isSelected = false
             }
             //setting the border to Visually select an image.
             cell?.layer.borderWidth = 4
             cell?.layer.borderColor = CGColor(red: 0, green: 5, blue: 5, alpha: 1)
             cell?.isSelected = true
             // preparing data for transition.
             imageCellIndex = indexPath.row
         }
    }
}

