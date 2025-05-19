//
//  Date+ExtensionTest.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import Testing
import ModKit
import Foundation

@Suite("Date Extension Tests")
struct DateExtensionTests {
    
    // MARK: - Date Component Tests
    
    @Test("day property returns correct value")
    func testDayProperty() {
        let date = DateComponents(calendar: .current, year: 2023, month: 5, day: 15).date!
        #expect(date.day == 15)
    }
    
    @Test("month property returns correct value")
    func testMonthProperty() {
        let date = DateComponents(calendar: .current, year: 2023, month: 12, day: 1).date!
        #expect(date.month == 12)
    }
    
    @Test("year property returns correct value")
    func testYearProperty() {
        let date = DateComponents(calendar: .current, year: 2025, month: 1, day: 1).date!
        #expect(date.year == 2025)
    }
    
    // MARK: - Date Checks
    
    @Test("isToday correctly identifies today's date")
    func testIsToday() {
        let today = Date()
        #expect(today.isToday)
        
        let notToday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        #expect(!notToday.isToday)
    }
    
    // MARK: - Formatting Tests
    
    @Test("string formatting works correctly")
    func testStringFormatting() {
        let date = DateComponents(calendar: .current, year: 2023, month: 5, day: 15).date!
        #expect(date.string(format: "yyyy-MM-dd") == "2023-05-15")
        #expect(date.string(format: "MM/dd/yy") == "05/15/23")
        #expect(date.string(format: "MMMM d, yyyy") == "May 15, 2023")
    }
    
    // MARK: - Time Ago Display Tests
    
    @Test("timeAgoDisplay shows correct string for years")
    func testTimeAgoYears() {
        let calendar = Calendar.current
        let yearsAgo = calendar.date(byAdding: .year, value: -2, to: Date())!
        #expect(yearsAgo.timeAgoDisplay() == "2 years ago")
        
        let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: Date())!
        #expect(oneYearAgo.timeAgoDisplay() == "1 year ago")
    }
    
    @Test("timeAgoDisplay shows correct string for months")
    func testTimeAgoMonths() {
        let calendar = Calendar.current
        let monthsAgo = calendar.date(byAdding: .month, value: -3, to: Date())!
        #expect(monthsAgo.timeAgoDisplay() == "3 months ago")
        
        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date())!
        #expect(oneMonthAgo.timeAgoDisplay() == "1 month ago")
    }
    
    @Test("timeAgoDisplay shows correct string for weeks")
    func testTimeAgoWeeks() {
        let calendar = Calendar.current
        let weeksAgo = calendar.date(byAdding: .weekOfYear, value: -2, to: Date())!
        #expect(weeksAgo.timeAgoDisplay() == "2 weeks ago")
        
        let oneWeekAgo = calendar.date(byAdding: .weekOfYear, value: -1, to: Date())!
        #expect(oneWeekAgo.timeAgoDisplay() == "1 week ago")
    }
    
    @Test("timeAgoDisplay shows correct string for days")
    func testTimeAgoDays() {
        let calendar = Calendar.current
        let daysAgo = calendar.date(byAdding: .day, value: -5, to: Date())!
        #expect(daysAgo.timeAgoDisplay() == "5 days ago")
        
        let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        #expect(oneDayAgo.timeAgoDisplay() == "1 day ago")
    }
    
    @Test("timeAgoDisplay shows correct string for hours")
    func testTimeAgoHours() {
        let calendar = Calendar.current
        let hoursAgo = calendar.date(byAdding: .hour, value: -3, to: Date())!
        #expect(hoursAgo.timeAgoDisplay() == "3 hours ago")
        
        let oneHourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        #expect(oneHourAgo.timeAgoDisplay() == "1 hour ago")
    }
    
    @Test("timeAgoDisplay shows correct string for minutes")
    func testTimeAgoMinutes() {
        let calendar = Calendar.current
        let minutesAgo = calendar.date(byAdding: .minute, value: -10, to: Date())!
        #expect(minutesAgo.timeAgoDisplay() == "10 minutes ago")
        
        let oneMinuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        #expect(oneMinuteAgo.timeAgoDisplay() == "1 minute ago")
    }
    
    @Test("timeAgoDisplay shows correct string for seconds")
    func testTimeAgoSeconds() {
        let calendar = Calendar.current
        let secondsAgo = calendar.date(byAdding: .second, value: -30, to: Date())!
        #expect(secondsAgo.timeAgoDisplay() == "30 seconds ago")
        
        let justNow = calendar.date(byAdding: .second, value: -2, to: Date())!
        #expect(justNow.timeAgoDisplay() == "Just now")
    }
    
    @Test("timeAgoDisplay shows 'Just now' for recent dates")
    func testTimeAgoJustNow() {
        let now = Date()
        #expect(now.timeAgoDisplay() == "Just now")
        
        let twoSecondsAgo = Calendar.current.date(byAdding: .second, value: -2, to: now)!
        #expect(twoSecondsAgo.timeAgoDisplay() == "Just now")
    }
}
