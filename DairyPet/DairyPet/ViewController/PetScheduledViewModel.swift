//
//  PetMedicalViewModel.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 12.06.2022.
//

import Foundation

class PetScheduledViewModel : ObservableObject{
    @Published var scheduledEvents : [ScheduleInfo] = []
    

    func getAllEventsWithID(petID : String){
        scheduledEvents = CoreDataManager.shared.getAllInformationScheduledID(petid: UUID(uuidString: petID)!).map(ScheduleInfo.init)
    }
    
    func getEventsAll(){
        scheduledEvents = CoreDataManager.shared.getAllInformationScheduled().map(ScheduleInfo.init)
    }
    
    
    func saveEvent(petID : String ,title : String, desc : String, date : Date, reminder : Bool){
        let schedules = ScheduleInformation(context: CoreDataManager.shared.viewContextSchedule)
        schedules.petID = UUID(uuidString: petID)
        schedules.eventTitle = title
        schedules.eventDesc = desc
        schedules.eventReminder = reminder
        schedules.eventDate = date
        CoreDataManager.shared.save()
    }
    
    
    
    func delete(_ schedule: ScheduleInfo) {
        
        let existingTask = CoreDataManager.shared.getInfoByIdFromScheduled(id: schedule.id)
        if let existingTask = existingTask {
            CoreDataManager.shared.deleteInfoFromSchedule(task: existingTask)
        }
    }
    
    
    func addScheduleEvent(petID: String, title: String, desc: String, date: Date, reminder: Bool){
        do{
            try CoreDataManager.shared.addSchedule(petID: petID, title: title, desc: desc, date: date, reminder: reminder)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    func getPetImage(petID : String){
        do {
            try CoreDataManager.shared.getSelectedPetsImage(petid: UUID(uuidString: petID)!)
        }catch{
            print(error.localizedDescription)
        }
    }
}
