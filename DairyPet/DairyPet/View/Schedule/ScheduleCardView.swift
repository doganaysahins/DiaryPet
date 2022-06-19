//
//  ScheduleCardView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 19.06.2022.
//

import SwiftUI

struct ScheduleCardView: View {
    var scheduleTitle : String
    var scheduleDesc : String
    var scheduleDate : String
    var selectedImage : UIImage
    var body: some View {
        
            ZStack(alignment : .leading){
                
                Color("babyBlue")
                
                HStack{
                    VStack(alignment : .leading, spacing: 10){
                        HStack{
                            Text(scheduleTitle)
                                .font(.title3.bold())
                            Spacer()
                            Text(scheduleDesc)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        
                        HStack{
                            Image(systemName:"calendar")
                            Text(scheduleDate)
                                .font(.caption.bold())
                            
                        }.foregroundColor(.gray)
                        
                        
                        HStack{
                            
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                
                                .frame(width: 30, height: 30, alignment: .center)
                            
                            
                        }.font(.callout)
                        
                    }
                }.padding()
               
                    
                
            
            }

    }
}

struct ScheduleCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCardView(scheduleTitle: "Title", scheduleDesc: "Desc", scheduleDate: "dateeee", selectedImage: UIImage())
    }
}
