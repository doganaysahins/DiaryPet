//
//  ImagePickerViewModel.swift
//  Petwatch
//
//  Created by Doğanay Şahin on 22.04.2022.
//

import Foundation
import SwiftUI

class ImagePickerViewModel : ObservableObject{
    
    @Published var image : UIImage?
    @Published var showPicker = false
    @Published var source : PickerTypes.Source = .library

    
    
    func showMePicker(){
        if source == .camera{
            if !PickerTypes.checkPermissions(){
                print("Give allows to camera")
                return
            }
        }
        
        showPicker = true
    }
    
    
    init(){
        
    }
}


enum PickerTypes{
    enum Source : String{
        case library, camera
    }
    
    
    static func checkPermissions() -> Bool{
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            return true
        }else{
            return false
        }
    }
}
