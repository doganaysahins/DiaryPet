//
//  ContentView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 18.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State var showSheet = false

  
    @StateObject private var infoListVM = PetInformationViewModel()

    init() {
        UITableView.appearance().backgroundColor = .white
        }
    
    
    func deletePet(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = infoListVM.tasks[index]
            infoListVM.delete(task)
        }
        infoListVM.getAllTasks()
    }
    
    var body: some View {
        


        
        NavigationView{
            VStack{
                NavigationLink(destination:


                                PetAddView().navigationBarTitleDisplayMode(.inline)
                               

                .navigationTitle("Add your pet")
                               ,isActive: $showSheet)
                { EmptyView() }.isDetailLink(false)
                    
                if infoListVM.tasks.isEmpty{
                    VStack(spacing : 25){
                        Spacer()
                        
                        EmptyListsView()
                    }.padding()
                    
                }
                    
                List{
                    
                    
                    ForEach(infoListVM.tasks , id : \.id){ info in
                        let tagColour = Color(red: info.red, green: info.green, blue: info.blue, opacity: info.alpha)
                        
                        ListingCardView(name:info.name, type: info.type, birthDate: info.birthDate, petImage: info.imagePet ?? UIImage(), backgrounColor: tagColour).background(NavigationLink("", destination: {
                            
                                ProfileView(infos: info).navigationBarTitleDisplayMode(.inline)
                            
                                
                        }))
                            
                            
                    }
                    
                    .onDelete(perform: deletePet)
                    
                    
                    .listRowSeparator(.hidden)
                    

                }
                
               
                    

                
                
                
            }
            .onAppear(perform: {
                infoListVM.getAllTasks()
            })

            
            
                .navigationTitle(Text("Your pets"))
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.showSheet.toggle()
                            
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



