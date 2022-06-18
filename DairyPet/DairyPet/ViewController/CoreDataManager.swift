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
    
    var viewContextMedicine: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var viewContextSchedule: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    
    func addMedicine(petID : String, medicineName : String, medicineMG : String, medicineDose : Double, medicineDuration: String, medicineBegin : String, medicineFinish : String){
        let medicineToAdd = getMedByID(petid: UUID(uuidString: petID)!)
        
        if let medicineToAdd = medicineToAdd {
            medicineToAdd.medicineName = medicineName
            medicineToAdd.medicineMG = medicineMG
            medicineToAdd.medicineDose = medicineDose
            medicineToAdd.medicineDuration = medicineDuration
            medicineToAdd.medicineBegin = medicineBegin
            medicineToAdd.medicineFinish = medicineFinish
            try save()
        }
    }
    
    
    func addSchedule(petID : String, title : String, desc : String, date : Date, reminder: Bool){
        let scheduleToAdd = getScheduleByID(petid: UUID(uuidString: petID)!)
        
        if let scheduleToAdd = scheduleToAdd {
            scheduleToAdd.eventTitle = title
            scheduleToAdd.eventDesc = desc
            scheduleToAdd.eventDate = date
            scheduleToAdd.eventReminder = reminder
            try save()
        }
    }
    
    func getImageByID(petid : UUID) -> PetInformation? {
        let request : NSFetchRequest<PetInformation> = PetInformation.fetchRequest()
        request.predicate = NSPredicate(format: "petID = %@", (petid.uuidString))
        
        let results = try! self.viewContext.fetch(request)
        return results.first
    }
    
    
    func getScheduleByID(petid : UUID) -> ScheduleInformation? {
        let request : NSFetchRequest<ScheduleInformation> = ScheduleInformation.fetchRequest()
        request.predicate = NSPredicate(format: "petID = %@", (petid.uuidString))
        
        let results = try! self.viewContext.fetch(request)
        return results.first
    }
    
    
    
    func getMedByID(petid : UUID) -> MedicineInformation? {
        let request : NSFetchRequest<MedicineInformation> = MedicineInformation.fetchRequest()
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
    
    
    func getInfoByIdFromMed(id: NSManagedObjectID) -> MedicineInformation? {
        
        do {
            return try viewContext.existingObject(with: id) as? MedicineInformation
        } catch {
            return nil
        }
        
    }
    func getInfoByIdFromScheduled(id: NSManagedObjectID) -> ScheduleInformation? {
        
        do {
            return try viewContext.existingObject(with: id) as? ScheduleInformation
        } catch {
            return nil
        }
        
    }
    
    func deleteInfo(task: PetInformation) {
        
        viewContext.delete(task)
        save()
        
    }
    
    
    func deleteInfoFromMED(task: MedicineInformation) {
        
        viewContext.delete(task)
        save()
        
    }
    
    func deleteInfoFromSchedule(task: ScheduleInformation) {
        
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
    
    func getAllInformationScheduled() -> [ScheduleInformation] {
        let request : NSFetchRequest<ScheduleInformation> = ScheduleInformation.fetchRequest()
        
        do {
            return try viewContextSchedule.fetch(request)
        } catch {
            return []
        }
    }
    
    func getAllInformationScheduledID(petid: UUID) -> [ScheduleInformation] {
        let request : NSFetchRequest<ScheduleInformation> = ScheduleInformation.fetchRequest()
        request.predicate = NSPredicate(format: "petID = %@", (petid.uuidString))
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
    func getAllInformationMedicine(petid: UUID) -> [MedicineInformation] {
        let request : NSFetchRequest<MedicineInformation> = MedicineInformation.fetchRequest()
        request.predicate = NSPredicate(format: "petID = %@", (petid.uuidString))
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
