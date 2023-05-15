//
//  Int+Extension.swift
//  MoneyLeftCoreData
//
//  Created by Admin on 10/10/2022.
//

import Foundation
extension Int {
    func formatMoneyValue() -> String{
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.locale = .init(identifier: "en")
        formater.numberStyle = .decimal
        formater.minimumFractionDigits = 0
        return formater.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Int32 {
    func formatMoneyValue() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.locale = .init(identifier: "en")
        formater.numberStyle = .decimal
        formater.minimumFractionDigits = 0
        return formater.string(from: NSNumber(value: self)) ?? ""
    }
}
