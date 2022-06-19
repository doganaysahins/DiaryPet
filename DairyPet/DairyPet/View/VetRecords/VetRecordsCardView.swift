//
//  VetRecordsCardView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 19.06.2022.
//

import SwiftUI

struct VetRecordsCardView: View {
    var infos : PetInfo
    var body: some View {
        ZStack(alignment : .leading){
            let tagColour = Color(red: infos.red, green: infos.green, blue: infos.blue, opacity: infos.alpha)
            tagColour.opacity(0.1)
            
            HStack{
                VStack(alignment : .leading, spacing: 10){
                    HStack{
                        Text("Title")
                            .font(.title3.bold())
                        Spacer()
                        Text("Desc")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    
                    HStack{
                        Image(systemName:"calendar")
                        Text("Date")
                            .font(.caption.bold())
                        
                    }.foregroundColor(.gray)
                    
                    
//                    HStack{
//                        Image(systemName: medicineType ? "pills" : "drop")
//                        Text("\(Int(medicineDose)) Dose")
//                        Spacer()
//                        Text(duration)
//                    }.font(.callout)
                    
                }
            }.padding()
           
                
            
        
        }

    }
}

struct VetRecordsCardView_Previews: PreviewProvider {
    static var previews: some View {
        VetRecordsCardView(infos: PetInfo(info: PetInformation()))
    }
}
