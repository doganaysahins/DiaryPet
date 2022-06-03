//
//  NewScrollView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 2.06.2022.
//

import SwiftUI

struct NewScrollView: View {
    
    @StateObject private var infoListVM = PetInformationViewModel()
    
    func deletePet(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = infoListVM.tasks[index]
            infoListVM.delete(task)
        }
        infoListVM.getAllTasks()
    }
    
    var body: some View {
        NavigationView{
            
        
        
        ScrollView(.horizontal, showsIndicators: false) {




            HStack{

                
                    
                

                ForEach(infoListVM.tasks , id : \.id){ i in
                    
                    NavigationLink {
                        ProfileView(infos: i)
                    } label: {
                        
                        let tagColour = Color(red: i.red, green: i.green, blue: i.blue, opacity: i.alpha)
                        ListingCardView(name: i.name, type: i.type, birthDate: i.birthDate, petImage: i.imagePet ?? UIImage(), backgrounColor: tagColour)
                            
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .buttonStyle(.plain)
                    .contextMenu{
                        
                        Button {
                            
                            
                        } label: {
                            Text("Delete")
                        }

                    }

                    
                
                        
                       
                    }
                

               






            }.onAppear {
                infoListVM.getAllTasks()
            }


        }
        }
    }
}

struct NewScrollView_Previews: PreviewProvider {
    static var previews: some View {
        NewScrollView()
    }
}
