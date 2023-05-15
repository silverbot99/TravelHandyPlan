//
//  MonthPicker.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 04/04/2023.
//

import SwiftUI

struct MonthPicker: View {
    @Binding var selectedMonth: Date
    private let months: [Date]

    init(selectedMonth: Binding<Date>) {
        self._selectedMonth = selectedMonth

        // Generate an array of Date objects for the last 12 months
        let now = Date()
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        self.months = (0..<12).compactMap { calendar.date(byAdding: .month, value: -$0, to: startOfMonth) }
    }

    var body: some View {
        Picker("Month", selection: $selectedMonth) {
            ForEach(months, id: \.self) { month in
                Text(dateFormatter.string(from: month))
            }
        }
        .pickerStyle(MenuPickerStyle())
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
}
