//
//  Constants.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 12/01/2022.
//

import Foundation
import UIKit
struct K{
    static let cellReuseId = "MainViewCell"
    static let categoryCell = "categoryCell"
    static let colorArray = [
        UIColor.systemBlue,
        UIColor.systemBrown,
        UIColor.systemGreen,
        UIColor.systemIndigo,
        UIColor.systemOrange,
        UIColor.systemPink,
        UIColor.systemPurple,
        UIColor.systemRed,
        UIColor.systemTeal,
        UIColor.systemYellow,
        UIColor.systemCyan
    ]
    static let colorPickerCell = "colorPickerCell"
    static let imagePickerCell = "imagePickerCell"
    static let checkmark = "CheckmarkImage"
    static let heartSquare = "heart.square"
    static let pencilSquare = "square.and.pencil"
    static let boltCar = "bolt.car"
    static let phone = "phone"
    static let cart = "cart"
    static let pet = "petIcon"
    static let plane = "airplane"
    static let dinner = "dinnerIcon"
    static let laptop = "laptopcomputer"
    
    static let imageArray = [
        UIImage(systemName: "laptopcomputer")?.withTintColor(.black, renderingMode: .automatic),
        UIImage(systemName: "airplane")?.withTintColor(.black, renderingMode: .automatic),
    UIImage(systemName: "cart")?.withTintColor(.black, renderingMode: .automatic),
    UIImage(systemName: "bolt.car")?.withTintColor(.black, renderingMode: .automatic),
    UIImage(systemName: "heart.square")?.withTintColor(.black, renderingMode: .automatic),
    UIImage(systemName: "square.and.pencil")?.withTintColor(.black, renderingMode: .automatic),
    UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .automatic)]
    static let segueTomain = "backToMain"
    static let segueCreate = "creation"
}
