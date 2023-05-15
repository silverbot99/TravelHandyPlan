//
//  Float+Extension.swift
//  MoneyLeftCoreData
//
//  Created by Ngan Huynh on 03/07/2022.
//

import Foundation

extension Float {
    func formatMoneyValue() -> String{
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.locale = .init(identifier: "en")
        formater.numberStyle = .decimal
        formater.minimumFractionDigits = 0
        return formater.string(from: NSNumber(value: self)) ?? ""
    }
}
