//
//  ContactUs_Sub_SubmitFile_Controller.swift
//  OneIBC
//
//  Created by BIN CG on 15/10/2021.
//

import Foundation
import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct FileGet {
    var fileType = ""
    var fileUrl = ""
    var fileContent = ""
    var fileSize = 0
}

enum typePopUpAlert {
    case alert, thankyou, exceed, delete
}

struct DocumentPicker_View: View {
    
    @Binding var arrFile:Array<FileGet>
    @Binding var isAlertFile: Bool
    @Binding var choosePopUpAlert: typePopUpAlert

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
               DocumentPicker(arrFile: $arrFile, isAlertFile: $isAlertFile, choosePopUpAlert: $choosePopUpAlert)
           }
       }
}

struct DocumentPicker: UIViewControllerRepresentable {
    
    @Binding var arrFile:Array<FileGet>
    @Binding var isAlertFile: Bool
    @Binding var choosePopUpAlert: typePopUpAlert

    @State var sizeOfUploadFile : Int = 5000000
    @State var listValidFileTypeTransfer: [String] = [
        "pdf","jpg", "gif", "png"
    ]
    
    @State var file = FileGet()
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    func makeCoordinator() -> DocumentPicker.Coordinator {
        return DocumentPicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        
        let supportedTypes: [UTType] = [UTType.image, UTType.pdf, UTType.audio, UTType.epub]
        
        let picker =  UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes , asCopy: true)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: DocumentPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        var parent: DocumentPicker  // get data @Binding
        
        var size = 0
        
        init(parent1: DocumentPicker){
            parent = parent1
        }
        
        //MARK: ---------------------------action of picking document--------------------------//
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print(urls)
            var base64String = ""
            do {
                let data = try Data(contentsOf: urls.first!)
                base64String = data.base64EncodedString()
                
            }catch {
                
            }
            if let url = urls.first{
                
                let sizeRS = getASize(url: "\(url)")
                
                parent.file = FileGet(fileType: trimString(str: "\(url)"),
                                      fileUrl: "\(url)" ,
                                      fileContent: base64String,
                                      fileSize: sizeRS)
                guard checkSize(url: "\(url)" ) else {
                    return
                }
                guard checkFileType(trimString(str: "\(url)")) else {
                    parent.choosePopUpAlert = .alert
                    parent.isAlertFile = true
                    return
                }
            }

            parent.arrFile.insert(parent.file, at: 0)
            
            parent.presentationMode.wrappedValue.dismiss()
           
        }
        
        func getASize(url:String) -> Int {
            size = 0
            do {
                let resources = try URL(string: url )?.resourceValues(forKeys:[.fileSizeKey])
                size = (resources?.fileSize) ?? 0
                
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
                
            } catch {
                print("Error: \(error)")
            }
            if sizeCheck > parent.sizeOfUploadFile {
               //"Exceeded file size limit"     --> alert
                parent.isAlertFile = true
            }
            return sizeCheck <= parent.sizeOfUploadFile         // 20MB / file
        }
        
        func checkFileType(_ fileType: String) -> Bool {
            if parent.listValidFileTypeTransfer.contains(fileType) {
                return true
            }
            return false
        }
    }
}
