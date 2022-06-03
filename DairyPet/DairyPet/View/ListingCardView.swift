//
//  ListingCardView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 21.05.2022.
//

import SwiftUI

struct ListingCardView: View {
    var name : String
    var type : String
    var birthDate : String
    var petImage : UIImage
    var backgrounColor : Color
    var body: some View {
        
        
        
        
        
        
        ZStack(alignment: .leading) {
                    
            Color("babyBlue")
                
                    HStack {
                        ZStack {
                            
//                            AsyncImage(url: URL(string: petImage)) {
//                                imz in
//                                imz.resizable()
//                                    .scaledToFit()
//                                    .clipShape(Circle())
//                                    .overlay(content: {
//                                        Circle().stroke(Color.white, lineWidth: 3)
//                                    })
//                                    .padding(.leading, 10)
//                                    .padding(.trailing, 10)
//                                    .shadow(radius: 5)
//                                    .frame(width: 180, height:180, alignment: .center)
//
//                            }placeholder: {
//                                ProgressView()
//                            }
                               
                                
                           
                                
                                
                            

                            Image(uiImage: petImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .overlay(Circle()
                                    .stroke(backgrounColor, lineWidth: 3))
                                
                                .shadow(radius: 5)
                                .frame(width: 100, height:100, alignment: .center)

                        }

                        .frame(width: 100, height: 70, alignment: .center)
                        
                        
                        VStack(alignment: .leading) {
                            Text(name)
                                
                                .font(.system(size: 25).bold())
                                .lineLimit(2)
                                .padding([.bottom, .top], 5)
                            
                            Text(type)
                                .padding(.bottom, 5)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack(alignment: .center) {
                                Image(systemName: "calendar")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(birthDate)
                                    .font(.caption)
                                    .foregroundColor(.gray)

                            }
                            .padding(.bottom, 5)
                            

                            
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding(15)
                }
        .frame(height: 300, alignment: .center)
        
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            
            
    }


struct ListingCardView_Previews: PreviewProvider {
    static var previews: some View {
        ListingCardView(name: "Test", type: "Test", birthDate: "12-12-2022", petImage:  UIImage(), backgrounColor: .red)
    }
}
