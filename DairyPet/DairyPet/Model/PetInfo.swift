//
//  PetInfo.swift
//  Petwatch
//
//  Created by Doğanay Şahin on 21.04.2022.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

struct PetInfo{
    
    let info : PetInformation
    
    var id : NSManagedObjectID {
        return info.objectID
    }
    
    var petID : String {
        guard let petID = self.info.petID else{
            return ""
        }
        
        return petID.uuidString
    }
    
    var type : String{
        return info.type ?? " "
    }
    
    var name : String{
        return info.name ?? " "
    }
    
    var imagePet : UIImage?{
        guard let data = info.imagePet else {
            return nil
        }
        return UIImage(data: data)
    }
    

    var red : Double{
        return info.red
    }
    
    var blue : Double{
        return info.blue
    }
    
    var green : Double{
        return info.green
    }
    
    var alpha : Double{
        return info.alpha
    }
    
    
    var petGender : String{
        return info.gender ?? ""
    }
    
    var petWeight : String {
        return info.weight ?? ""
    }
    
    var petBreed : String {
        return info.breed ?? ""
    }
    
    var birthDate : String{
        return info.brithDate ?? ""
    }
    
    var ownerName : String{
        return info.ownerName ?? ""
    }
    
    var ownerAdress : String{
        return info.ownerAdress ?? ""
    }
    
    var ownerPhone : String{
        return info.ownerPhone ??  ""
        
    }
    
    var ownerEmail : String{
        return info.ownerPhone ?? ""
    }
    

    
}


//struct PetsViewState{
//    
//    var imagePetNew : UIImage?{
//        guard let data = info.imagePet else {
//            return nil
//        }
//        return UIImage(data: data)
//    }
//}



struct MedicineInfo {
    
    let medInfo : MedicineInformation
    
    
    var id : NSManagedObjectID {
        return medInfo.objectID
    }
    
    var petID : String {
        guard let petID = self.medInfo.petID else{
            return ""
        }
        
        return petID.uuidString
    }
    
    var petMedicineName : String{
        return medInfo.medicineName ?? ""
    }
    
    var petMedmg : String{
        return medInfo.medicineMG ?? ""
    }
    
    var petMedicineDose : Double{
        return medInfo.medicineDose
    }
    
    var petMedicineBegin : String{
        return medInfo.medicineBegin ?? ""
    }
    var petMedicineFinish : String{
        return medInfo.medicineFinish ?? ""
    }
    
    var petMedicineDuration : String{
        return medInfo.medicineDuration ?? ""
    }
    
    var petMedicineType : Bool{
        return medInfo.medType 
    }
}
