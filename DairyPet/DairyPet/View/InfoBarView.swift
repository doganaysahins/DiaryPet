//
//  InfoBarView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 18.05.2022.
//

import SwiftUI

struct InfoBarView: View {
    var petGender : String
    var petWeight : String
    var petBreed : String
    var petBirthDate : String
    
    
    var body: some View {
        HStack{
            Color.white
                .overlay {
                    HStack{
                        VStack{
                            
                            
                            Text(petBreed == "" ? "Breed" : petBreed)
                                
                                    .font(Font.system(size: 10))
                                    .padding()
                                Image(systemName: "circle.grid.hex")
                                    
                                    .padding(.bottom)
                            
                        
                                
                            
                        }.foregroundColor(.gray)
                        VStack{
                            Text(petBirthDate)
                                .font(Font.system(size: 10))
                                
                                .padding()
                            Image(systemName: "calendar")
                                
                                .padding(.bottom)
                            
                        }.foregroundColor(.gray)
                        VStack{
                            Text(petWeight == "" ? "Weight" : petWeight)
                                .font(Font.system(size: 10))
                            
                                .padding()
                            Image(systemName: "w.square.fill")
                                
                                .padding(.bottom)
                             
                        }
                        .foregroundColor(.gray)
                        VStack{
                            Text(petGender == "" ? "Gender" : petGender)
                                .font(Font.system(size: 10))
                                .padding()
                            Image(systemName: "arrow.up.right.circle")
                                
                                .padding(.bottom)
                               
                        }
                        .foregroundColor(.gray)
                    }
                    
                }
        }.clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
            .frame(height: 100, alignment: .top)
            .shadow(radius: 2)
        
        
        
    }
}

struct InfoBarView_Previews: PreviewProvider {
    static var previews: some View {
        InfoBarView(petGender: "", petWeight: "", petBreed: "", petBirthDate: "")
    }
}
