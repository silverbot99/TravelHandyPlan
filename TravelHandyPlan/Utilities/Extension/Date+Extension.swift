//
//  Date+Extension.swift
//  MoneyLeftCoreData
//
//  Created by Admin on 08/11/2022.
//

import Foundation
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    func dateToString(format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month],
                                    from: Calendar.current.startOfDay(for: self))) ?? Date()
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()) ?? Date()
    }
    
    func getMondayThisWeek() -> Date {
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        comps.weekday = 2 // Monday
        let mondayInWeek = cal.date(from: comps)!
        return mondayInWeek
    }
    
    func getSundayThisWeek() -> Date {
        let monday = self.getMondayThisWeek()
        
        let sunday = Calendar.current.date(byAdding: .day, value: 6, to: monday)
        
        return sunday ?? Date()
    }
    
    func getNextDay() -> Date {
        
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: self)
        
        return nextDay ?? Date()
    }
    
    func getWeekIndexOfDate() -> Int {
        let calendar = Calendar.current
        let weekStartOfMonth = calendar.component(.weekOfYear, from: self)
        return weekStartOfMonth
    }
    
    func getNumberWeeksOfThisMonth() -> Int {
        let calendar = Calendar.current
        let weekStartOfMonth = calendar.component(.weekOfYear, from: self.startOfMonth())
        let weekEndOfMonth = calendar.component(.weekOfYear, from: self.endOfMonth())
        return (weekEndOfMonth - weekStartOfMonth) + 1
    }
    
    func getStartDateFromWeekNum(weekOfYear: Int) -> Date? {
        let year = Calendar.current.component(.year, from: self)
        var components = DateComponents(weekOfYear: weekOfYear, yearForWeekOfYear: year)
        components.weekday = 2
        if let date = Calendar.current.date(from: components) {
            return date
        }
        else {
            return nil
        }
    }
    
    func getEndDateFromWeekNum(weekOfYear: Int) -> Date? {
        let startDate = self.getStartDateFromWeekNum(weekOfYear: weekOfYear)
        if startDate != nil {
            let endDate: Date = Calendar.current.date(byAdding: .day, value: 6, to: startDate!) ?? Date()
            
            let endThisMonth: Date = self.endOfMonth()
            if endDate <= endThisMonth {
                return endDate
            }
            else {
                return endThisMonth
            }
            
        }
        else {
            return nil
        }
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
    
    func toString(dateFormat: String = "dd MMM, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = NSLocale.current
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func getIntDateFromNow() -> Int {
        let today = Date()

        let delta = self - today
        
        return delta.day ?? 0
    }
    
    var year: Int { Calendar.current.component(.year, from: self) }
}
