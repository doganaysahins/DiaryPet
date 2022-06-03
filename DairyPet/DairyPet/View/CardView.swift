//
//  CardView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 18.05.2022.
//

import SwiftUI

struct CardView : View{
//    var petInfo : PetInfo
    var name : String 
    var type : String
    var petGender : String
    var petWeight : String
    var petBreed : String
    var birthDate : String
    var petImage : UIImage
    var circleColor : Color
    @StateObject var imgPicker = ImagePickerViewModel()
    @State var showPickerMenu = false
    @State var confirmationDialog = false
    
    var body: some View{
        
        
        VStack{
            
        
        
        ZStack(alignment: .leading) {
                    
                   
                    HStack {
                        
                        
                        
                        VStack(alignment: .leading) {

                            
                            Text(type)
                                .foregroundColor(.gray)
                            Text(name == "" ? "Pet name" : name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                            
//                            HStack(alignment: .center) {
//                                Image(systemName: "mappin")
//                                Text("petInfo.onDiet")
//
//                            }
//                            .padding(.bottom, 5)
                            
                            
                        }
                        .padding(.horizontal, 5)
                        Spacer()
                        ZStack {
                                
                            HStack(alignment : .bottom, spacing: -20){
                                
                                Image(uiImage: petImage)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .overlay(Circle()
                                        .stroke(circleColor, lineWidth: 3))
                                    .padding(.leading, 10)
                                    .shadow(radius: 5)
                                    .frame(width: 100, height:100, alignment: .center)
                                
//                                Button {
//                                    self.confirmationDialog.toggle()
//                                } label: {
//                                    Image(systemName: "camera.on.rectangle.fill")
//                                }
                            }
                           
 
                            }

                            .frame(width: 100, height: 70, alignment: .center)
                          
             
                        
                      
        

                      
                        
                        
                        
                        
                        
                      
                    }
            
                    .padding(15)



            
                }
            
        
            InfoBarView(petGender: petGender, petWeight: petWeight, petBreed: petBreed, petBirthDate: birthDate)
        }
        
            }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(name: "", type: "", petGender: "", petWeight: "", petBreed: "", birthDate: "", petImage: UIImage(), circleColor: .black)
    }
}
