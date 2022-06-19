//
//  VetRecordsView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 19.06.2022.
//

import SwiftUI

struct VetRecordsView: View {
    @State var showForm = false
    @State var titleEvent = ""
    @State var descEvent = ""
    @State var currentDate = Date()
    @StateObject private var scViewModel = PetScheduledViewModel()
    var infos : PetInfo
    var body: some View {
        VStack{

            
            List{
                
                ForEach(scViewModel.scheduledEvents, id : \.id) { eventForPet in
                    
                        
                       VetRecordsCardView(infos: infos)
                        
                    
                    
                   
                }.listRowSeparator(.hidden)


            
            }
            
            

           
        }
        .frame(height: 500)
        .frame(maxWidth: .infinity,alignment: .center)
        
        .overlay(
            
                
           
            VStack{
               
            
            HStack{
                
                
                Spacer()
                Button {
                    self.showForm.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
                
            }
                Spacer()
            }.padding()
            
        )
        
        
        .onAppear {
            scViewModel.getAllEventsWithID(petID: infos.petID)
        }
        
        
    }
    
    
    var sheetBodyForm : some View{
        return NavigationView{
            Form{
                Section("Title"){
                    TextField("Title", text: $titleEvent)
                }
                Section("Description"){
                    TextEditor(text: $descEvent)
                }
      
                Section("Time"){
                    DatePicker("Time", selection: $currentDate, displayedComponents: .hourAndMinute)
                        
                }
                
                Section("Remind Me"){
//                    Toggle("Remind Me", isOn: $infoListVM.reminder)
                }
                
                
                
                Button {
                    print("added")
                    let cl = Calendar.current
                    let dc = cl.dateComponents([.year,.month,.day,.weekday,.hour,.minute], from: currentDate)


                    
                 
                    self.showForm = false
                    

                    
                }
            
            
                label: {
                    Text("Add")
                }
                
            }
//            }.navigationBarTitle(Text(convertToDateComp(selectedDate:currentDate)), displayMode: .inline)
//
        
            
            
        
        }
        
      
            
       
       
        
    }
}

struct VetRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        VetRecordsView(infos: PetInfo(info: PetInformation()))
    }
}
