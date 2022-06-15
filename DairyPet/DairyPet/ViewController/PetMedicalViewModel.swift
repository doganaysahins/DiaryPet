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

    
    
    func saveMed(petID : String ,medName : String, medDose : Double, medFin : String, medBegin : String, medDuration : String, medMG : String, medType : Bool){
        let meds = MedicineInformation(context: CoreDataManager.shared.viewContextMedicine)
        meds.petID = UUID(uuidString: petID)
        meds.medicineName = medName
        meds.medicineDose = medDose
        meds.medicineFinish = medFin
        meds.medicineMG = medMG
        meds.medicineBegin = medBegin
        meds.medType = medType
        meds.medicineDuration = medDuration
        CoreDataManager.shared.save()
    }
    
    
    
    func delete(_ med: MedicineInfo) {
        
        let existingTask = CoreDataManager.shared.getInfoByIdFromMed(id: med.id)
        if let existingTask = existingTask {
            CoreDataManager.shared.deleteInfoFromMED(task: existingTask)
        }
    }
    
    
    func addMedicineToPet(petID: String, medicineName: String, medicineMG: String, medicineDose: Double, medicineDuration: String, medicineBegin: String, medicineFinish: String){
        do{
            try CoreDataManager.shared.addMedicine(petID: petID, medicineName: medicineName, medicineMG: medicineMG, medicineDose: medicineDose, medicineDuration: medicineDuration, medicineBegin: medicineBegin, medicineFinish: medicineFinish)
        }catch{
            print(error.localizedDescription)
        }
    }
}
