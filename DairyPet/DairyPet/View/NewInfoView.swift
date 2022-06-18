//
//  NewInfoView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 18.06.2022.
//

import SwiftUI

struct NewInfoView: View {
    var infoBreed : String = "Breed"
    var birthDate : String
    var infoWeight : String = "0"
    var infoTpye : String = "Gender"
    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack{
                InfoItem(infoText: infoBreed.isEmpty ? "Breed" : infoBreed, imageName: "circle.grid.hex")
                InfoItem(infoText: birthDate.isEmpty ? "Birth Date" : birthDate, imageName: "calendar")
                InfoItem(infoText: infoWeight.isEmpty ? "Weignt" : infoWeight, imageName: "w.square.fill")
                InfoItem(infoText: infoTpye.isEmpty ? "Gender" : infoTpye, imageName: "arrow.up.right.circle")
                
       
            }.frame(maxWidth: .infinity)
                
           
         
            
//        })
            
        

        
    }
}


struct InfoItem : View{
    var infoText : String
    var imageName : String
    var body: some View{
        
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .frame(width: 80, height: 80, alignment: .center)
            .shadow(color: Color("babyBlue"), radius: 25)
            
            .overlay(
                VStack(spacing : 15){
                    Image(systemName: imageName)
                        
                        .foregroundColor(.gray)
                        
                    Text(infoText)
                        .multilineTextAlignment(.center)
                        
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            
            )
        
        
    }
}

struct NewInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NewInfoView(infoBreed: "breed", birthDate: "", infoWeight: "", infoTpye: "")
    }
}
