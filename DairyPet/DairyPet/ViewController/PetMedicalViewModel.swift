//
//  PetMedicalViewModel.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 12.06.2022.
//

import Foundation

class PetMedicineViewModel : ObservableObject{
    @Published var medicals : [MedicineInfo] = []
    
    
    func getAllMeds(){
        medicals = CoreDataManager.shared.getAllInformationMedicine().map(MedicineInfo.init)
    }

    
    
    func saveMed(petID : String ,medName : String, medDose : Double, medFin : String, medBegin : String, medDuration : String){
        let meds = MedicineInformation(context: CoreDataManager.shared.viewContextMedicine)
        meds.petID = UUID(uuidString: petID)
        meds.medicineName = medName
        meds.medicineDose = medDose
        meds.medicineFinish = medFin
        
        meds.medicineBegin = medBegin
        
        meds.medicineDuration = medDuration
        CoreDataManager.shared.save()
    }
    
    
    func addMedicineToPet(petID: String, medicineName: String, medicineMG: String, medicineDose: Double, medicineDuration: String, medicineBegin: String, medicineFinish: String){
        do{
            try CoreDataManager.shared.addMedicine(petID: petID, medicineName: medicineName, medicineMG: medicineMG, medicineDose: medicineDose, medicineDuration: medicineDuration, medicineBegin: medicineBegin, medicineFinish: medicineFinish)
        }catch{
            print(error.localizedDescription)
        }
    }
}
