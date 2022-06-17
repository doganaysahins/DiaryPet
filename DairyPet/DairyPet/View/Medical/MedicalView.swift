//
//  MedicalView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 12.06.2022.
//

import SwiftUI

struct MedicalView: View {
    
    @State var addMedical = false
    @State var pillPicker = true
    @State var liqPicker = false
    @State var isListEmpty = 0
    @State var beginDate = Date()
    @State var finishDate = Date()
    @State var medicineName = ""
    @State var medicineMG = ""
    @State private var value : Double = 0
    @State private var selected = "Every hour"
    @StateObject private var medViewModel = PetMedicineViewModel()
    var infos : PetInfo
    let colors: [Color] = [.orange, .red, .gray, .blue,
                               .green, .purple, .pink]
    
    
    func deletePet(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = medViewModel.medicals[index]
            medViewModel.delete(task)
        }
        medViewModel.getAllMeds(petID: infos.petID)
    }

    var body: some View {
        
        
            
        
        
        
        
            
        
            VStack{

                

                    
                
                List{
                    
                    ForEach(medViewModel.medicals, id : \.id) { medicalInfo in
                        
                            
                            MedicalCardView(medicineTitle: medicalInfo.petMedicineName, medicineBeginDate: medicalInfo.petMedicineBegin, medicineFinDate: medicalInfo.petMedicineFinish, medicineDose: medicalInfo.petMedicineDose, medicineMG: medicalInfo.petMedmg, duration: medicalInfo.petMedicineDuration, medicineType: medicalInfo.petMedicineType)
                            
                        
                        
                       
                    }.onDelete(perform: deletePet)
                        .listRowSeparator(.hidden)

                
                }.emptyPlaceholder(medViewModel.medicals) {
                    EmptyMedicalView()
                        .padding()
                }
                
                

               
            }
            .frame(height: 500)
            .frame(maxWidth: .infinity,alignment: .center)
            
            .overlay(
                
                    
               
                VStack{
                   
                
                HStack{
                    
                    
                    Spacer()
                    Button {
                        self.addMedical.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                    }
                    
                }
                    Spacer()
                }.padding()
                
            )
        
        
                

                
               
            
            

            .onAppear(perform: {
                medViewModel.getAllMeds(petID: infos.petID)
            })
            
            .sheet(isPresented: $addMedical, onDismiss: {
                medViewModel.getAllMeds(petID: infos.petID)
            }) {
                
                VStack{
                    
                        GroupBox {
                            GroupBox{
                                
                            
                            VStack {
                                Picker("Flavor", selection: $pillPicker) {
                                    Text("Pill")
                                        .tag(true)
                                    Text("Liquid")
                                        .tag(false)
                                }
                                
                            }
                            .pickerStyle(.segmented)
                            .padding()
                            }.groupBoxStyle(CardGroupBoxStyle())
                            
                            TextField("Medicine Name", text: $medicineName)
                                .underlineTextField()
                                
                            TextField("mG", text: $medicineMG)
                                .underlineTextField()
                            
                            
                            HStack(alignment : .center){
                                
                           
                            GroupBox{
                                
                                HStack{
                                    
                                
                                
                                Picker("Flavor", selection: $selected) {
                                    Text("Every hour")
                                        .tag("Ever hour")
                                    Text("Every 12 hours")
                                        .tag("Every 12 hours")
                                    Text("Everyday")
                                        .tag("Everyday")
                                    Text("Every week")
                                        .tag("Every week")
                                    Text("Every month")
                                        .tag("Every month")
                                }
                                Stepper("\(Int(value))" + " dose") {
                                    incrementStep()
                                } onDecrement: {
                                    decrementStep()
                                }

                            }
                                    
                            }.groupBoxStyle(CardGroupBoxStyle())
   
                                
                                    
                            

                            }
                            

                            

                            
                            

                            
                            
                            HStack{
                                
                            
                            GroupBox("Begin") {
                                DatePicker("Begin", selection: $beginDate, displayedComponents: .date)
                                    .labelsHidden()
                                    
                                
                            }.groupBoxStyle(CardGroupBoxStyle())
                                Spacer()
                                GroupBox("Finish") {
                                    DatePicker("Begin", selection: $finishDate, displayedComponents: .date)
                                        
                                        .labelsHidden()
                                    
                                }.groupBoxStyle(CardGroupBoxStyle())
                            }
                            
                            
                        } label: {
                            Text("Medicine").font(.largeTitle.bold())
                        }
                        
                        
                        .groupBoxStyle(CardGroupBoxStyle())
                        
                        Spacer()
                }
                    
                    ZStack{
                        
                        
                            
                        
                    Button {
      
                        withAnimation {
                            
                            print(selected)
                            self.addMedical.toggle()
                            medViewModel.saveMed(petID: infos.petID, medName: medicineName, medDose: value, medFin: finishDate.formatted(date:.abbreviated, time: .omitted), medBegin: beginDate.formatted(date: .abbreviated, time: .omitted), medDuration: selected, medMG: medicineMG, medType: pillPicker)
                        }
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(medicineName.isEmpty ? .gray : .green)
                        Text("Done")
                            .foregroundColor(medicineName.isEmpty ? .gray : .green)
                    }.disabled(medicineName.isEmpty)
                                
                    }
                
                    }

            
        
            
                

            }
            
        
    func computeNewDate(from fromDate: Date, to toDate: Date) {
        let dateFormatter = DateFormatter()
         let delta = toDate.timeIntervalSince(fromDate)
         let today = Date()
         if delta < 0 {
             
              print(dateFormatter.string(from: today))
         } else {
             
             print(dateFormatter.string(from: today.addingTimeInterval(delta)))
         }
    }
    
    
    func incrementStep() {
        value += 1
       
    }
    func decrementStep() {
        value -= 1
        
    }
    
    
    
}

struct MedicalView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalView(infos: PetInfo(info: PetInformation()))
    }
}


struct CardGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(Color("babyBlue").opacity(0.5))
//        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
