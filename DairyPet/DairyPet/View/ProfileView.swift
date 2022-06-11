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
    @State var selection = 0
    @State var confirmationDialog = false
    @State var imageChanged = false
    @Environment(\.presentationMode) private var presentationMode
    var infos : PetInfo
    @StateObject var imgPicker = ImagePickerViewModel()
    @StateObject private var infoListVM = PetInformationViewModel()

    
    var body: some View {
        
            
        
        ScrollView(.vertical, showsIndicators: false) {
            let tagColour = Color(red: infos.red, green: infos.green, blue: infos.blue, opacity: infos.alpha)
        
        HStack{
            VStack(alignment : .leading){
                Text(infos.birthDate)
                    .font(.caption)
                    
                    .fontWeight(.ultraLight)
                
                Button {
                    infoListVM.updateImagePet(newImage: imgPicker.image ?? UIImage(), petID: infos.petID)
                    
                } label: {
                    Text("Edit")
                }

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
            
        }
        .sheet(isPresented: $imgPicker.showPicker, onDismiss: {
            print("dissmisssss")
            infoListVM.updateImagePet(newImage: imgPicker.image ?? UIImage(), petID: infos.petID)
            infoListVM.getAllTasks()
        }){
            
            
                                ImagePicker(sourceType: imgPicker.source == .library ? .photoLibrary : .camera, selectedImage: $imgPicker.image)
            
                                    .ignoresSafeArea()
            
                

            
        }
        
            InfoBarView(petGender: infos.petGender, petWeight: infos.petWeight, petBreed: infos.petBreed, petBirthDate: infos.birthDate)
                    
            
            VStack{
                Tabs(tabs: .constant(["Medical Records","Scheduled visits","Vaccination","Detailed Information"]), selection: $selection, underlineColor: .black) { title, isSelected in
                    
                    Text(title)
                        
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.bottom,10)
                        .foregroundColor(isSelected ? .black : .gray)
                }
                
                switch selection{
                case 0:
                    EmptyView()
                case 1:
                    CustomDatePicker(currentDate: $cDate)
                case 2:
                    EmptyView()
                case 3:
                    DetailView(infos: infos)
                    
                default:
                    EmptyView()
                }
            }
            

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
        
        
                
        
    }

    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(infos: PetInfo(info: PetInformation()))
    }
}
