//
//  MedicalView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 12.06.2022.
//

import SwiftUI

struct MedicalView: View {
    
    @State var addMedical = false
    @State var pillPicker = 0
    @State var liqPicker = false
    @State var beginDate = Date()
    @State var finishDate = Date()
    @State var medicineName = ""
    @State var medicineMG = ""
    @State private var value : Double = 0
    @State private var selected = ""
    @StateObject private var medViewModel = PetMedicineViewModel()
    var infos : PetInfo
    let colors: [Color] = [.orange, .red, .gray, .blue,
                               .green, .purple, .pink]
    

    var body: some View {
        
        
            
        
        
            VStack {
                Spacer()
               
                List{
                    ForEach(medViewModel.medicals, id : \.id) { medicalInfo in
                        
                            Text(medicalInfo.petID)
                        Text(medicalInfo.petMedicineName)
                        

                       
                    }
                }
                
                
                HStack{
                    
                    Spacer()
                    Text(infos.petID)
                    Button {
                        self.addMedical.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                    }

                }
                .padding()
               
                
               
                
                
//                    .navigationTitle("Medical Record")
//                    .toolbar {
//                        Button {
//                            self.addMedical.toggle()
//                        } label: {
//                            Text("Add")
//                        }
//
//                    }
                
               
            
            }

            .onAppear(perform: {
                medViewModel.getAllMeds()
            })
            
            .sheet(isPresented: $addMedical, onDismiss: {
                medViewModel.getAllMeds()
            }) {
                
                VStack{
                    
                    GroupBox("Medicine type"){
                        
                    
                    VStack {
                        Picker("Flavor", selection: $pillPicker) {
                            Text("Pill")
                                .tag(0)
                            Text("Liquid")
                                .tag(1)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    }.groupBoxStyle(CardGroupBoxStyle())
                        
                    if pillPicker == 0{
                        GroupBox {
                            
                            
                            TextField("Medicine Name", text: $medicineName)
                                .underlineTextField()
                                
                            TextField("mG", text: $medicineMG)
                                .underlineTextField()
                            
                            
                            HStack(alignment : .center){
                                
                           
                            GroupBox{
                                
                                HStack{
                                    
                                
                                
                                Picker("Flavor", selection: $selected) {
                                    Text("Every hour")
                                    Text("Every 12 hours")
                                    Text("Everyday")
                                    Text("Every week")
                                    Text("Every month")
                            }
                                Stepper("\(value)" + " dose") {
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
                                
                                GroupBox("Finish") {
                                    DatePicker("Begin", selection: $finishDate, displayedComponents: .date)
                                        
                                        .labelsHidden()
                                    
                                }.groupBoxStyle(CardGroupBoxStyle())
                            }
                            
                            
                        } label: {
                            Text("Medicines")
                        }
                        
                        .padding()
                        .groupBoxStyle(CardGroupBoxStyle())
                        
                        
                    }
                    

                    Button {
      
                        withAnimation {
                            

                            self.addMedical.toggle()
                            medViewModel.saveMed(petID: infos.petID, medName: medicineName, medDose: value, medFin: finishDate.formatted(date: .complete, time: .omitted), medBegin: beginDate.formatted(date: .complete, time: .omitted), medDuration: selected)
                        }
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Done")
                            .foregroundColor(.green)
                    }
                    Spacer()
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
