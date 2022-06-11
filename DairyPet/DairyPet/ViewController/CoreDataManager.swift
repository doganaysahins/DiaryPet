//
//  CoreDataManager.swift
//  Petwatch
//
//  Created by Doğanay Şahin on 22.04.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager{
    
    let persistentContainer : NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getImageByID(petid : UUID) -> PetInformation? {
        let request : NSFetchRequest<PetInformation> = PetInformation.fetchRequest()
        request.predicate = NSPredicate(format: "petID = %@", (petid.uuidString))
        
        let results = try! self.viewContext.fetch(request)
        return results.first
    }
    
    func updateImage(petID : String, newImage : UIImage){
        let imageToBeUpdated = getImageByID(petid: UUID(uuidString: petID)!)
        
        if let imageToBeUpdated = imageToBeUpdated {
            imageToBeUpdated.imagePet = newImage.jpegData(compressionQuality: 0.5)
            try save()
        }
    }

    
    func getInfoById(id: NSManagedObjectID) -> PetInformation? {
        
        do {
            return try viewContext.existingObject(with: id) as? PetInformation
        } catch {
            return nil
        }
        
    }
    
    func deleteInfo(task: PetInformation) {
        
        viewContext.delete(task)
        save()
        
    }
    
    
    
    func getAllInformation() -> [PetInformation] {
        let request : NSFetchRequest<PetInformation> = PetInformation.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
    
    func save(){
        do {
            try viewContext.save()
        }catch{
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    
  
    
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "PetDiary")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
}
