//
//  DetailView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 26.05.2022.
//

import SwiftUI

struct DetailView: View {
    var infos : PetInfo
    @State var confirmationDialog = false
    @StateObject var imgPicker = ImagePickerViewModel()
    @StateObject private var infoListVM = PetInformationViewModel()
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
                    .overlay {
                        ZStack(alignment : .topLeading){
                            HStack{
                                Spacer()
                                Button {
                                    self.confirmationDialog.toggle()
                                } label: {
                                    Image(systemName: "camera.on.rectangle.fill")
                                        .padding(.bottom, 20)
                                }.padding(.trailing, 10)
                            }
                            Spacer()
                        }
                       

                    }
                Text(infos.name)
                    .font(Font.system(size: 28))
                
              
                NewInfoView(infoBreed: infos.petBreed, birthDate: infos.birthDate, infoWeight: infos.petWeight, infoTpye: infos.petGender)
               
                
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
                Button {
                    infoListVM.updateImagePet(newImage: imgPicker.image ?? UIImage(), petID: infos.petID)
                    infoListVM.getAllTasks()
                    
                } label: {
                    Text("Save Changes")
                }

                
                
                Spacer()
                
            }
            .sheet(isPresented: $imgPicker.showPicker) {
                
                
                                    ImagePicker(sourceType: imgPicker.source == .library ? .photoLibrary : .camera, selectedImage: $imgPicker.image)
                
                                        .ignoresSafeArea()
                
            

                
            }
                
            .confirmationDialog("Upload image", isPresented: $confirmationDialog) {
                Button {
                    imgPicker.source = .library
                    imgPicker.showMePicker()
                    
                } label: {
                    Text("From Photos")
                }
                
                Button {
                    imgPicker.source = .camera
                    imgPicker.showMePicker()
                } label: {
                    Text("From Camera")
                }

            }
            }.navigationViewStyle(.stack)
            
            
               
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(infos: PetInfo(info: PetInformation()))
    }
}
