//
//  EmptyListsView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 28.05.2022.
//

import SwiftUI

struct EmptyListsView: View {
    @State var goAddView = false
    var body: some View {
        
        NavigationLink(destination:


                        PetAddView().navigationBarTitleDisplayMode(.inline)
                       

        .navigationTitle("Add your pet")
                       ,isActive: $goAddView)
        { EmptyView() }.isDetailLink(false)
        
        
        RoundedRectangle(cornerRadius: 36)
            .frame(width: 300, height: 200, alignment: .center)
            .foregroundColor(Color("babyBlue"))
            .opacity(0.5)
            .overlay {
                VStack{
                    Text("It looks like you are not add any friend now!")
                        
                        .multilineTextAlignment(.center)
                        .padding()
                        
                        .foregroundColor(.gray)
                    Button {
                        self.goAddView.toggle()
                    } label: {
                        Text("Add a pet")
                            
                            .foregroundColor(.white)
                            
                            .padding()
                            
                    }
                    .background(.green)
                    .cornerRadius(20)

                }
               
                
            }
    }
}

struct EmptyListsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListsView()
    }
}
