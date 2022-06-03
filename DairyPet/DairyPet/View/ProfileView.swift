//
//  ProfileView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 26.05.2022.
//

import SwiftUI

struct ProfileView: View {
    @State var goDetails = false
    @State var goSchedule = false
    @State var goVaccination = false
    @State var goMedical = false
    @State var cDate = Date()
    
    
    var infos : PetInfo
    
    
    var body: some View {
        
            
        
        ScrollView(.vertical, showsIndicators: false) {
            let tagColour = Color(red: infos.red, green: infos.green, blue: infos.blue, opacity: infos.alpha)
        
        HStack{
            VStack(alignment : .leading){
                Text(infos.birthDate)
                    .font(.caption)
                    
                    .fontWeight(.ultraLight)
                Text(infos.name)
                    .font(.largeTitle)
            }
            .padding()
            Spacer()
            
            Image(uiImage: infos.imagePet ?? UIImage())
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .overlay(Circle()
                    .stroke(tagColour, lineWidth: 3))
                .padding(.leading, 10)
                .shadow(radius: 5)
                .frame(width: 80, height: 80, alignment: .center)
                .padding()
            
        }.padding()
        
            InfoBarView(petGender: infos.petGender, petWeight: infos.petWeight, petBreed: infos.petBreed, petBirthDate: infos.birthDate)
                    
            
            
            
            VStack(spacing : 0){
                HStack(spacing : 10){
                    Button {
                        self.goMedical.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 150, height: 200, alignment: .center)
                        
                        
                            .overlay {
                                VStack{
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        
                                    NavigationLink("Medical Record", destination:CustomDatePicker(currentDate: $cDate),isActive: $goMedical)
                                      
                                }.foregroundColor(.white)

                            }
                       
                            
                        
                       
                    }.foregroundColor(.green)
                       
                        
                        
                    Button {
                        self.goSchedule.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 150, height: 200, alignment: .center)
                        
                        
                            .overlay {
                                VStack{
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        
                                    NavigationLink("Scheduled visits", destination:EmptyView(),isActive: $goSchedule)
                                      
                                }.foregroundColor(.white)

                            }
                    }.foregroundColor(.green)
                       
                        
                }
                
                
                HStack(spacing : 10){
                    Button {
                        self.goDetails.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 150, height: 200, alignment: .center)
                        
                        
                            .overlay {
                                VStack{
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        
                                    NavigationLink("Detailed Information", destination:DetailView(infos: infos),isActive: $goDetails)
                                      
                                }.foregroundColor(.white)

                            }
                    }.foregroundColor(.green)
                    
                    Button {
                        self.goVaccination.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 150, height: 200, alignment: .center)
                        
                        
                            .overlay {
                                VStack{
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        
                                    NavigationLink("Vaccination schedule", destination:EmptyView(),isActive: $goVaccination)
                                      
                                }.foregroundColor(.white)

                            }
                    }.foregroundColor(.green)
                        
                        
                }.padding()

            }
        }
        
//        .navigationBarHidden(true)
        
        
                
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(infos: PetInfo(info: PetInformation()))
    }
}
