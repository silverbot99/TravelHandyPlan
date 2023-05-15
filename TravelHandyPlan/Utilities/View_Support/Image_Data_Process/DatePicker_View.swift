//
//  DatePicker.swift
//  OneIBC
//
//  Created by Quang Tran on 25/10/2021.
//

import SwiftUI

public class datePickerData : ObservableObject{
    @Published var data: Date = Date()
}

struct DatePicker_View: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @Binding var dataDate: String
    
    @State var selectedDate = datePickerData()
        
        var body: some View {
            ZStack{
                
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .frame(width: WV, height: HV, alignment: .center)
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 0){
                        Spacer().frame(width: WV/3)
                        
                        DatePicker("", selection: $selectedDate.data, displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                        
                        Spacer().frame(width: WV/3)
                    }
                    
                    Button{
                        print("go back")
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: .init(colors: [Color(#colorLiteral(red: 0, green: 0.4470588235, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.7764705882, blue: 1, alpha: 1))]),
                                      startPoint: .init(x: 0, y: 0),
                                      endPoint: .init(x: 1, y: 0)
                                    ))
                                .cornerRadius(8)
                                .frame(width: WV-32, height: 48, alignment: .center)
                            
                            Text("Done")
                                .foregroundColor(Color(hex: 0xffffff))
                                .font(.custom(FontType.Regular.rawValue, size: 18))
                        }.padding(.all, 16).padding(.bottom, 16)
                    }
                }
            }
            .padding()
            .onDisappear(perform: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let somedateString = dateFormatter.string(from: selectedDate.data)
                
                dataDate = somedateString
            })
        }
}
