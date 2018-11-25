//
//  UIViewController+CoreData.swift
//  Movies
//
//  Created by Lucas Santos on 16/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    var appDelegate: AppDelegate {
        // This unwrap will never fail, we want the app to crash if it does
        // swiftlint:disable force_cast
        return UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
    }
    var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error o salvar contexto: ", error)
            }
        }
    }
}
