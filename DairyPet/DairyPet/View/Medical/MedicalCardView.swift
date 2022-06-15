//
//  MedicalCardView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 15.06.2022.
//

import SwiftUI

struct MedicalCardView: View {
    var medicineTitle : String
    var medicineBeginDate : String
    var medicineFinDate : String
    var medicineDose : Double
    var medicineMG : String
    var duration : String
    var medicineType : Bool
    var body: some View {
        
            ZStack(alignment : .leading){
                
                Color("babyBlue")
                
                HStack{
                    VStack(alignment : .leading, spacing: 10){
                        HStack{
                            Text(medicineTitle)
                                .font(.title3.bold())
                            Spacer()
                            Text(medicineMG + " MG")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        
                        HStack{
                            Image(systemName:"calendar")
                            Text(medicineBeginDate + " - " + medicineFinDate)
                                .font(.caption.bold())
                            
                        }.foregroundColor(.gray)
                        
                        
                        HStack{
                            Image(systemName: medicineType ? "pills" : "drop")
                            Text("\(Int(medicineDose)) Dose")
                            Spacer()
                            Text(duration)
                        }.font(.callout)
                        
                    }
                }.padding()
               
                    
                
            
            }
        
        
      
        
    }
}

struct MedicalCardView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalCardView(medicineTitle: "Title", medicineBeginDate: "date", medicineFinDate: "findate", medicineDose: 1, medicineMG: "200", duration: "dur", medicineType: true)
    }
}
