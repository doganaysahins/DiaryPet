//
//  PetAddView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 28.05.2022.
//

import SwiftUI

struct PetAddView: View {
    
    @State var showSheet = false
    @State var petName : String = ""
    @State var selectedType = "Select a type"
    @State var selectedGender = ""
    @State private var selectedColor : Color = .yellow
    @State var weight = ""
    @State var breed = ""
    @State var birthDate = Date()
    @State var ownerName = ""
    @State var ownerAdress = ""
    @State var ownerPhone = ""
    @State var ownerEmail = ""
    @StateObject var imgPicker = ImagePickerViewModel()
    @StateObject private var infoListVM = PetInformationViewModel()
    @State private var showMessage = false
    @Environment(\.presentationMode) var presentationMode
    @State var confirmationDialog = false
    init() {
        UITableView.appearance().backgroundColor = .white
        }
    
    
    var body: some View {
        
            
            
        ScrollView(.vertical, showsIndicators: false){
            
        
        
        VStack {



            
            CardView(name : petName, type: selectedType, petGender: selectedGender, petWeight: weight, petBreed: breed, birthDate: dateFormatter(date: birthDate), petImage: imgPicker.image ?? UIImage(), circleColor: selectedColor)
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
          
               

            
            Picker(selection: $selectedGender) {
                Text("Female")
                    .tag("Female")
                Text("Male")
                    .tag("Male")
            } label: {
                Text("Gender")
            }
            .pickerStyle(.segmented)


            Picker(selection: $selectedType, label: Text("Type")) {
                Text("Cat")
                    .tag("Cat")
                Text("Dog")
                    .tag("Dog")
                Text("Fish")
                    .tag("Fish")
                Text("Bird")
                    .tag("Bird")
            }
            .pickerStyle(.segmented)
            TextField("Pet name", text: $petName)
                .underlineTextField()
            
            
            HStack(spacing: 10){
                
            
            TextField("Weight", text: $weight)
                .underlineTextField()
                .keyboardType(.decimalPad)
                GroupBox {
                    DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                        .labelsHidden()
                } label: {
                    Text("Birth Date")
                }

                 
                
            
              
            }
            HStack(spacing : 10){
                TextField("Breed", text: $breed)
                    .underlineTextField()
                
                GroupBox {
                    ColorPicker("Selected color", selection: $selectedColor, supportsOpacity: false)
                        
                        
                } label: {
                    Text("Pick a color")
                        
                }

              
            }
            
            Divider()
                .padding()
                
            
            GroupBox {
                TextField("Owner's name", text: $ownerName)
                    .underlineTextField()

                TextField("Owner's Adress", text: $ownerAdress)
                    .underlineTextField()


                TextField("Phone Number", text: $ownerPhone)
                    .underlineTextField()

                TextField("Email", text: $ownerEmail)
                    .underlineTextField()
            } label: {
                Text("Owner's Information")
            }
            



            

                Button {
  
                    withAnimation {
                        

                        self.showMessage.toggle()
                    }
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Done")
                        .foregroundColor(.green)
                }

     
               
        }.padding(.top, 5)
        }
        
        .overlay {
      
            if showMessage{
                if !petName.isEmpty
                    && !selectedType.isEmpty
                    && !selectedGender.isEmpty
                    && !weight.isEmpty
                    && !breed.isEmpty
                    && imgPicker.image != nil
                    
                {

                    ZStack{
                        
                    
                        Message(title: "Success!", message: "Your pet saved successfully", style: .success)
                            .onAppear {
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation {
                                        let red = Double(selectedColor.components.red)
                                        let green = Double(selectedColor.components.green)
                                        let blue = Double(selectedColor.components.blue)
                                        let alpha = Double(selectedColor.components.alpha)
                                        
                                         infoListVM.save(imgPet: imgPicker.image ?? UIImage(),
                                                         red: red, green: green, blue: blue, alpha: alpha, petName : self.petName, petType: selectedType, petGender: selectedGender,
                                         petBreed: breed,
                                         petWeight: weight,
                                         petBirth: dateFormatter(date: birthDate),
                                         ownerName: ownerName,
                                                         ownerAdress : ownerAdress,
                                                         ownerEmail : ownerEmail,
                                                         ownerPhone : ownerPhone)
                                        
                                        
                                        
                                  
                                        self.showMessage.toggle()
                                        withAnimation {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        
                                        
                                        
                                    }
                                    
                                }
                            }
                    
                    }
                    .zIndex(5)
                    
                   
                    
                }else{
                    
                    ZStack{
                        
                    
                        Message(title: "Fill all blanks", message: "Please fill all fields", style: .error)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation {
                                        self.showMessage.toggle()
                                    }
                                    
                                }
                            }
                    
                    }
                    .zIndex(5)
                    
                }

            }
        }
            
        .sheet(isPresented: $imgPicker.showPicker) {
                                ImagePicker(sourceType: imgPicker.source == .library ? .photoLibrary : .camera, selectedImage: $imgPicker.image)
                                    .ignoresSafeArea()
        }
            
        .padding()
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
    
    func dateFormatter(date : Date) -> String{
        
        let calendar = Calendar.current
        let dateComp = calendar.dateComponents([.year,.month,.day], from: date)
        
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
        return df.string(from: Calendar(identifier: .gregorian).date(from: dateComp)!)
    }
    }


struct PetAddView_Previews: PreviewProvider {
    static var previews: some View {
        PetAddView()
    }
}
