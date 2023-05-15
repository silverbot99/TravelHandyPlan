//
//  ContactUs_Sub_PhotoSubmit.swift
//  OneIBC
//
//  Created by BIN CG on 15/10/2021.
//
import Foundation
import SwiftUI
import UIKit

struct ImagePicker_View: View {
    
    @Binding var arrFile:Array<FileGet>
    @Binding var isAlertFile: Bool
    @Binding var isAvatar: Bool
    @State var maxSize: Int = 50000

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
       
       var body: some View {
           VStack{
            
               Button{
                   self.presentationMode.wrappedValue.dismiss()
               }label: {
                   HStack(alignment: .center, spacing: 0){
                       Text("Go back")
                       Spacer()
                   }.padding(.all, 16)
                   
               }
               ImagePicker(arrFile: $arrFile,
                           isAlertFile: $isAlertFile,
                           isAvatar: $isAvatar,
                           maxSize: $maxSize)
           }
       }
}


struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var arrFile:Array<FileGet>
    @Binding var isAlertFile: Bool
    @Binding var isAvatar: Bool
    @Binding var maxSize: Int
    @State var file = FileGet()
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker
        
        var size = 0

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
           
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ?? #imageLiteral(resourceName: "AvatarNotLogin")
            
            let imgData = chosenImage.jpegData(compressionQuality: 1)
            let stringData = imgData?.base64EncodedString()
            
            let url = "\(info[UIImagePickerController.InfoKey.imageURL] ?? "")"
            
            let sizeRS = getASize(url: "\(url)")

            guard checkSize(url: "\(info[UIImagePickerController.InfoKey.imageURL] ?? "")") else {
                return
            }
            
            if parent.isAvatar{
                //get avatar
                
                let resizeIMGAVATAR = resizeImage(image: chosenImage, targetSize: CGSize(width: 180, height: 180)) ?? #imageLiteral(resourceName: "AvatarNotLogin")

                let imgDataAvatar = resizeIMGAVATAR.jpegData(compressionQuality: 0.5)
                
                let imageSize: Int = imgDataAvatar?.count ?? 0
                
                print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
                
                parent.file = FileGet(fileType: trimString(str: url), fileUrl:  url, fileContent: stringData ?? "", fileSize: imageSize)
            }
            else{
                //contact us
                
                parent.file = FileGet(fileType: trimString(str: url), fileUrl:  url, fileContent: stringData ?? "", fileSize: sizeRS)
            }
            
            

            parent.arrFile.insert(parent.file, at: 0)
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func getASize(url:String) -> Int {
            size = 0
            do {
                let resources = try URL(string: url )?.resourceValues(forKeys:[.fileSizeKey])
                size = (resources?.fileSize) ?? 0
                print("File size = " + ByteCountFormatter().string(fromByteCount: Int64(size)) + "/maxSize: \(ByteCountFormatter().string(fromByteCount: Int64(parent.maxSize)))")

            } catch {
                print("Error: \(error)")
            }
            return size
        }
        
        func trimString(str: String) -> String {
            
            var fileName: String = ""
            fileName = str.components(separatedBy: ".").last ?? ""
            
            return "\(fileName)"
        }
        
        func checkSize(url:String)-> Bool{
            var sizeCheck = 0
            do {
                let resources = try URL(string: url )?.resourceValues(forKeys:[.fileSizeKey])
                sizeCheck = (resources?.fileSize) ?? 0
                print("File size = " + ByteCountFormatter().string(fromByteCount: Int64(sizeCheck)) + "/maxSize: \(ByteCountFormatter().string(fromByteCount: Int64(parent.maxSize)))")
            } catch {
                print("Error: \(error)")
            }
            if sizeCheck > parent.maxSize {
               //"Exceeded file size limit"     --> alert
                
                parent.presentationMode.wrappedValue.dismiss()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Avoid bug UI on ios 14 and 15
                    self.parent.isAlertFile = true
                }
            }
            return sizeCheck <= parent.maxSize         // 20MB / file
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
