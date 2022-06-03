//
//  DetailView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 26.05.2022.
//

import SwiftUI

struct DetailView: View {
    var infos : PetInfo
    var body: some View {
        
            
            ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0){
                let tagColour = Color(red: infos.red, green: infos.green, blue: infos.blue, opacity: infos.alpha)
                Image(uiImage: infos.imagePet ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(tagColour, lineWidth: 3))
                    
                    .shadow(radius: 5)
                    .frame(width: 180, height: 180, alignment: .center)
                    
                Text(infos.name)
                    .font(Font.system(size: 28))
                
              
                InfoBarView(petGender: infos.petGender, petWeight: infos.petWeight, petBreed: infos.petBreed, petBirthDate: infos.birthDate)
                
                GroupBox{
                    
                    VStack(alignment : .leading){
                        HStack(spacing : 50){
                            Text("Owner's name")
                                .foregroundColor(.gray)
                                
                            Text(infos.ownerName)
                        }.padding(.bottom, 20)
                        
                    
                        
                        HStack(spacing : 50){
                            Text("Phone number")
                                
                                .foregroundColor(.gray)
                            Text(infos.ownerPhone)
                        }.padding(.bottom, 20)
                        
                        HStack(spacing : 100){
                            Text("Address")
                                
                                .foregroundColor(.gray)
                            Text(infos.ownerAdress)
                                .lineLimit(2)
                        }.padding(.bottom, 20)
                        
                        HStack(spacing : 60){
                            Text("Email")
                                
                                .foregroundColor(.gray)
                            Text(infos.ownerEmail)
                                .lineLimit(1)
                                
                        }.padding(.bottom, 20)
                    }
                    
                }.padding()
                
                Spacer()
                
            }
            }.navigationViewStyle(.stack)
            
            
               
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(infos: PetInfo(info: PetInformation()))
    }
}
