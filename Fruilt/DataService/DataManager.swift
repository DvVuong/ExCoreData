//
//  DataManager.swift
//  Fruilt
//
//  Created by admin on 15/09/2022.
//

import Foundation
import CoreData
import UIKit
open class DataManger: NSObject {
    public static let sharedInstance = DataManger()
    private override init() {}
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveFruilt(_ fruilt: FruiltData) {
        
        let fruiltData = FruiltEntity(context: context)
        fruiltData.name = fruilt.name
        saveContext()
    }
    func saveFruits(_ data: [FruiltData])  {
        for item in data {
            let fruiltData = FruiltEntity(context: context)
            fruiltData.name = item.name
        }
        saveContext()
    }
    
    func getFruilt() -> [FruiltData] {
        var listFruit: [FruiltData] = []
        //var fr: [FruiltEntity] = []
        let frFetch: NSFetchRequest<FruiltEntity> = FruiltEntity.fetchRequest()
        do {
            let results = try context.fetch(frFetch)
            for item in results {
                let fruit = FruiltData(name: item.name ?? "", id: item.objectID)
                listFruit.append(fruit)
            }
            return listFruit
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return []
    }
    
    func updateName(_ name: String, with id: NSManagedObjectID) {
        if let object = try? context.existingObject(with: id) as? FruiltEntity {
            object.name = name
            saveContext()
        }
    }
    func deleteById(_ id: NSManagedObjectID) {
        if let object = try? context.existingObject(with: id) {
            context.delete(object)
            saveContext()
        }
    }
    
    
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "FruiltDatabase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}

