//
//  CameraPicker.swift
//  OneIBC
//
//  Created by Quang Tran on 10/11/2021.
//

import Foundation
import SwiftUI
import UIKit

struct CameraPicker_View: View {
    
    @Binding var arrFile:Array<FileGet>
    @Binding var isAlertFile: Bool
   
       var body: some View {
           CameraPicker(arrFile: $arrFile, isAlertFile: $isAlertFile)
       }
}


struct CameraPicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
       
    }
    
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    @Binding var arrFile:Array<FileGet>
    @Binding var isAlertFile: Bool
    
    @State var file = FileGet()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: CameraPicker
        
        var size = 0

        init(_ parent: CameraPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
           
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ?? #imageLiteral(resourceName: "AvatarNotLogin")
            
            let resizeIMG = resizeImage(image: chosenImage, targetSize: CGSize(width: 180, height: 180)) ?? #imageLiteral(resourceName: "AvatarNotLogin")

            let imgData = resizeIMG.jpegData(compressionQuality: 0.5)
            let stringData = imgData?.base64EncodedString()
            
            let imageSize: Int = imgData?.count ?? 0
            
            print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
            
            parent.file = FileGet(fileType: "", fileUrl:  "", fileContent: stringData ?? "", fileSize: imageSize)

            parent.arrFile.insert(parent.file, at: 0)
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func trimString(str: String) -> String {
            
            var fileName: String = ""
            fileName = str.components(separatedBy: ".").last ?? ""
            
            return "\(fileName)"
        }
        
        func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
            let size = image.size
            
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height
            
            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
            }
            
            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRect(origin: .zero, size: newSize)
            
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }
    }
}
