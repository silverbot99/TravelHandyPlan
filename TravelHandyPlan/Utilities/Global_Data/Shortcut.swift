//
//  Shortcut.swift
//  TravelHandyPlan
//
//  Created by Ngan Huynh on 14/05/2023.
//

import Foundation
class Unities {
    
    class func getGreetingByTime() -> String{
        let date = Date()
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "HH"
        
        let minuteFormatter = DateFormatter()
        minuteFormatter.dateFormat = "mm"
        
        let hourString = hourFormatter.string(from: date)
        //Morning: 5:00 -> 11:59
        //Afternoon: 12:00 -> 16:59
        //Evening: 17:00 -> 4:59
        let hourInt: Int = Int(hourString) ?? 1
        if hourInt >= 5 && hourInt < 11 {
                return "Chào buổi sáng"
        }
        else if hourInt >= 12 && hourInt < 16{
            return "Chào buổi trưa"
        }
        else {
            return "Chào buổi tối"
        }
    }
}
