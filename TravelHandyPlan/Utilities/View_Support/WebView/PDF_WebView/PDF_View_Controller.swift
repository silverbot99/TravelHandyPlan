//
//  PDF_View_Controller.swift
//  OneIBC
//
//  Created by Quang Tran on 28/10/2021.
//

import PDFKit
import SwiftUI
import WebKit

struct PDF_View_Controller: View {
    
    @Binding var fileNamePDF: String
    @Binding var pdfContentDATA: String // base 64 or url string
    
    @Binding var isBase64Data: Bool
    
    @Binding var isShare: Bool
    
    @State var destinationFileUrl = URL(string: "")
    
    @State var urlLink:URL?
    
    var body: some View {
        PDFWebView(pdfContentDATA: $pdfContentDATA)
            .frame(width: WV, alignment: .center)
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationTitle(fileNamePDF)
            .navigationBarHidden(false)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        sharePDFAction()
                    }label: {
                        Image("Share")
                    }
                }
            }
            .onAppear(perform: {
                let url = self.getDocumentsDirectory().appendingPathComponent(fileNamePDF)
                
                if isBase64Data {
                    if pdfContentDATA != ""{
                        guard let decodeData = Data(base64Encoded: pdfContentDATA, options: .ignoreUnknownCharacters) else{
                            return
                        }
                        if let pdf = PDFDocument.init(data: decodeData){
                            pdf.write(to: url)
                            
                            self.urlLink = url
                        }
                    }
                }
                else {
                    //load url webview
                    print("Load webView")
                }
                
            })
            .onDisappear(perform: {
                if destinationFileUrl != URL(string: "") {
                    removingFileInFileManager(destinationFileUrl: destinationFileUrl!)
                }
            })
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func sharePDFAction(){
        
        if fileNamePDF.isEmpty{
         return
        }
        
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
            destinationFileUrl = documentsUrl.appendingPathComponent("\(fileNamePDF)")
        
        do {
            //Show UIActivityViewController to save the downloaded file
            let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for indexx in 0..<contents.count {
                
                if contents[indexx].lastPathComponent == destinationFileUrl?.lastPathComponent {

                    //append data inside DispatchQueue.main.async avoid error "Thread 1: Fatal error: Can't remove last element from an empty collection"
                DispatchQueue.main.async {

                        
                        let activityController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)

                        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
                    }
                }
            }
        }
        catch (let err) {

            //append data inside DispatchQueue.main.async avoid error "Thread 1: Fatal error: Can't remove last element from an empty collection"
                DispatchQueue.main.async {
               
                removingFileInFileManager(destinationFileUrl: destinationFileUrl!)
                
//                ErrorUI().errorMessage(msg: "error: \(err)", completion: .fail, errorCode: 0)
            }
        }
    }
    
    func removingFileInFileManager(destinationFileUrl: URL){
        
        do {
                try FileManager.default.removeItem(at: destinationFileUrl)
                print("File deleted: \(destinationFileUrl)")
            }
        catch {
                print("Error")
        }
    }

}


struct PDFWebView : UIViewRepresentable {

    @Binding var pdfContentDATA: String
       
      func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
      }
       
      func updateUIView(_ uiView: WKWebView, context: Context) {
          guard let decodeData = Data(base64Encoded: pdfContentDATA, options: .ignoreUnknownCharacters) else{
              return
          }
          
          uiView.load(decodeData, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: URL(fileURLWithPath: ""))
      }
}
