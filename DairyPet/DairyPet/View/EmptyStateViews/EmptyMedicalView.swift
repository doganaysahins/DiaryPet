//
//  EmptyMedicalView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 16.06.2022.
//

import SwiftUI

struct EmptyMedicalView: View {
    var body: some View {
        VStack{
            
            
                HStack{
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                    Text("Your pet seems healty!")
                        
                        .multilineTextAlignment(.center)
                        
                        
                        .foregroundColor(.gray)
                    
                    
                    

                }
            Spacer()
        }.padding()
            
                
            }
    }


struct EmptyMedicalView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyMedicalView()
    }
}
