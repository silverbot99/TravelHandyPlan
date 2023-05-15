//
//  Double+Extension.swift
//  MoneyLeftCoreData
//
//  Created by Admin on 08/12/2022.
//

import Foundation

extension Double {
    func decimal() -> String{
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.locale = .init(identifier: "en")
        formater.numberStyle = .decimal
        formater.minimumFractionDigits = 2
        return formater.string(from: NSNumber(value: self)) ?? ""
    }
    func fileSize() -> String{
        let formater = NumberFormatter()
        formater.locale = .init(identifier: "en")
        formater.numberStyle = .decimal
        formater.groupingSeparator = ","
        formater.minimumFractionDigits = 2
        formater.minimumIntegerDigits = 2
        formater.maximumFractionDigits = 2
        return formater.string(from: NSNumber(value: self)) ?? ""
    }
   
    func checkFractionDigits() -> Bool {
        if self == Double(Int(self)) {
            return true
        }

        let integerString = String(Int(self))
        let doubleString = String(Double(self))
        let decimalCount = doubleString.count - integerString.count - 1

        return decimalCount<3
    }
}
