//
//  PetInformationViewModel.swift
//  Petwatch
//
//  Created by Doğanay Şahin on 22.04.2022.
//

import Foundation
import CoreData
import UIKit







class PetInformationViewModel : ObservableObject {
    @Published var name : String = " "
    @Published var type : String = " "
    @Published var gender : String = " "
    @Published var weight : String = " "
    @Published var breed : String = " "
    @Published var birthDate : String = " "
    
//    @Published var red : Double = 0
//    @Published var green : Double = 0
//    @Published var blue : Double = 0
//    @Published var alpha : Double = 0
    var imagePet : UIImage?
    @Published var tasks: [PetInfo] = []
    
    
    
    func getAllTasks() {
        tasks = CoreDataManager.shared.getAllInformation().map(PetInfo.init)
    }
    
    func updateImagePet(newImage : UIImage, petID : String){
        do {
            try CoreDataManager.shared.updateImage(petID: petID , newImage: newImage)
        }catch{
            print(error.localizedDescription)
        }
    }
    

    
    
    
    func delete(_ task: PetInfo) {
        
        let existingTask = CoreDataManager.shared.getInfoById(id: task.id)
        if let existingTask = existingTask {
            CoreDataManager.shared.deleteInfo(task: existingTask)
        }
    }
    
    func save(imgPet : UIImage?, red : Double, green: Double, blue: Double, alpha : Double, petName: String, petType : String, petGender : String,
              petBreed : String, petWeight : String, petBirth : String, ownerName : String, ownerAdress : String, ownerEmail : String, ownerPhone : String) {
        
        let task = PetInformation(context: CoreDataManager.shared.viewContext)
        task.petID = UUID()
        task.name = petName
        task.type = petType
        task.gender = petGender
        task.breed = petBreed
        task.weight = petWeight
        task.brithDate = petBirth
        task.ownerName = ownerName
        task.ownerEmail = ownerEmail
        task.ownerPhone = ownerPhone
        task.ownerAdress = ownerAdress
        
        task.red = red
        task.green = green
        task.blue = blue
        task.alpha = alpha
        task.imagePet = imgPet?.jpegData(compressionQuality: 0.5)

        CoreDataManager.shared.save()
    }
    
    
}
